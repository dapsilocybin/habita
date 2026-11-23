import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:habita/data/models/joined_habit_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddRecordProvider {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<JoinedHabit>> fetchJoinedHabits() async {
    final userId = _client.auth.currentUser?.id;

    if (userId == null) {
      throw StateError('User is not authenticated.');
    }

    final records = await _client
        .from('user_habits')
        .select('''
          id,
          habit_id,
          habits!user_habits_habit_id_fkey!inner (
            id,
            name
          )
        ''')
        .eq('user_id', userId)
        .eq('status', 'active')
        .eq('habits.is_active', true)
        .eq('habits.is_joinable', true);

    return records.map((record) {
      final habit = record['habits'] as Map<String, dynamic>;

      return JoinedHabit.fromMap({
        'id': record['id'],
        'habit_id': habit['id'],
        'name': habit['name'],
      });
    }).toList();
  }

  Future<void> publishRecord({
    required String userHabitId,
    required String caption,
    Uint8List? imageBytes,
    String? imageName,
  }) async {
    final userId = _client.auth.currentUser?.id;

    if (userId == null) {
      throw StateError('User is not authenticated.');
    }

    final recordId = imageBytes == null ? null : _newRecordId();
    final extension = imageBytes == null ? null : _imageExtension(imageName);
    final imagePath = recordId == null
        ? null
        : '$userId/$recordId/image.$extension';
    final recordValues = <String, dynamic>{
      'user_id': userId,
      'user_habit_id': userHabitId,
      'caption': caption.trim(),
      'visibility': 'public',
      'image_path': imagePath,
    };

    if (recordId != null) {
      recordValues['id'] = recordId;
    }

    final record = await _client
        .from('habit_records')
        .insert(recordValues)
        .select('id')
        .single();

    if (imageBytes == null || imagePath == null || extension == null) return;

    final insertedRecordId = record['id'] as String;
    final storage = _client.storage.from('habit-record-images');

    try {
      await storage.uploadBinary(
        imagePath,
        imageBytes,
        fileOptions: FileOptions(
          contentType: _imageContentType(extension),
          upsert: false,
        ),
      );
    } catch (error, stackTrace) {
      try {
        await storage.remove([imagePath]);
      } catch (cleanupError, cleanupStackTrace) {
        debugPrint('Failed to clean up uploaded record image: $cleanupError');
        debugPrintStack(stackTrace: cleanupStackTrace);
      }

      try {
        await _client
            .from('habit_records')
            .delete()
            .eq('id', insertedRecordId)
            .eq('user_id', userId);
      } catch (cleanupError, cleanupStackTrace) {
        debugPrint('Failed to clean up habit record: $cleanupError');
        debugPrintStack(stackTrace: cleanupStackTrace);
      }

      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  String _newRecordId() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;

    final hex = bytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-${hex.substring(16, 20)}-'
        '${hex.substring(20)}';
  }

  String _imageExtension(String? imageName) {
    if (imageName == null || imageName.trim().isEmpty) return 'jpg';

    final fileName = imageName.trim();
    final separator = fileName.lastIndexOf('.');
    if (separator <= 0 || separator == fileName.length - 1) return 'jpg';

    final extension = fileName.substring(separator + 1).toLowerCase();
    return RegExp(r'^[a-z0-9]+$').hasMatch(extension) ? extension : 'jpg';
  }

  String _imageContentType(String extension) {
    return switch (extension) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'webp' => 'image/webp',
      _ => 'application/octet-stream',
    };
  }
}
