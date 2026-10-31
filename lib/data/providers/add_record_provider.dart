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
          habit_id,
          frequency_type,
          target_count,
          target_period,
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
        'id': habit['id'],
        'name': habit['name'],
        'frequency_type': record['frequency_type'],
        'target_count': record['target_count'],
        'target_period': record['target_period'],
      });
    }).toList();
  }

  Future<void> publishRecord({
    required String habitId,
    required String caption,
    required String frequencyLabel,
    Uint8List? imageBytes,
    String? imageName,
  }) async {
    final userId = _client.auth.currentUser?.id;

    if (userId == null) {
      throw StateError('User is not authenticated.');
    }

    final record = await _client
        .from('habit_records')
        .insert({
          'user_id': userId,
          'habit_id': habitId,
          'caption': caption.trim(),
          'frequency_label': frequencyLabel,
          'visibility': 'public',
          'image_path': null,
        })
        .select('id')
        .single();

    if (imageBytes == null) return;

    final recordId = record['id'] as String;
    final extension = _imageExtension(imageName);
    final imagePath = '$userId/$recordId/image.$extension';
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

      await _client
          .from('habit_records')
          .update({'image_path': imagePath})
          .eq('id', recordId)
          .eq('user_id', userId)
          .select('id')
          .single();
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
            .eq('id', recordId)
            .eq('user_id', userId);
      } catch (cleanupError, cleanupStackTrace) {
        debugPrint('Failed to clean up habit record: $cleanupError');
        debugPrintStack(stackTrace: cleanupStackTrace);
      }

      Error.throwWithStackTrace(error, stackTrace);
    }
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
