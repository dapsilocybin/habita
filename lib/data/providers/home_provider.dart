import 'package:habita/data/models/habit_post_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeProvider {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<HabitPost>> fetchPosts() async {
    // Fetch the latest public records.
    final records = await _client
        .from('habit_records')
        .select('''
          id,
          user_id,
          habit_id,
          caption,
          image_path,
          frequency_label,
          created_at,
          profiles!habit_records_user_id_fkey (
            username,
            full_name
          ),
          habits!habit_records_habit_id_fkey (
            name
          ),
          post_likes (
            count
          ),
          post_comments (
            count
          )
        ''')
        .eq('visibility', 'public')
        .isFilter('deleted_at', null)
        .order('created_at', ascending: false)
        .limit(30);

    if (records.isEmpty) {
      return [];
    }

    // Collect unique user/habit combinations.
    // We only count public records for the feed milestone.
    final uniquePairs = <String, List<String>>{};

    for (final record in records) {
      final userId = record['user_id'] as String;
      final habitId = record['habit_id'] as String;
      final key = '$userId::$habitId';

      uniquePairs.putIfAbsent(key, () => [userId, habitId]);
    }

    // Fetch counts for each unique user/habit combination.
    final countEntries = await Future.wait(
      uniquePairs.entries.map((entry) async {
        final userId = entry.value[0];
        final habitId = entry.value[1];

        final response = await _client
            .from('habit_records')
            .select('id')
            .eq('user_id', userId)
            .eq('habit_id', habitId)
            .eq('visibility', 'public')
            .isFilter('deleted_at', null)
            .count(CountOption.exact);

        return MapEntry(entry.key, response.count ?? 0);
      }),
    );

    final recordCounts = Map<String, int>.fromEntries(countEntries);

    // Convert database records into HabitPost models.
    return records.map((record) {
      final profile = record['profiles'] as Map<String, dynamic>? ?? {};

      final habit = record['habits'] as Map<String, dynamic>? ?? {};

      final userId = record['user_id'] as String;
      final habitId = record['habit_id'] as String;
      final key = '$userId::$habitId';

      final imagePath = record['image_path'] as String?;

      final imageUrl = imagePath == null || imagePath.isEmpty
          ? null
          : _client.storage.from('habit-record-images').getPublicUrl(imagePath);

      final createdAt = DateTime.parse(
        record['created_at'] as String,
      ).toLocal();

      return HabitPost(
        id: record['id'] as String,
        username: profile['username'] as String? ?? '',
        userFullName: profile['full_name'] as String? ?? '',
        habitName: habit['name'] as String? ?? '',
        frequency: record['frequency_label'] as String? ?? 'نامشخص',
        habitRecordCount: recordCounts[key] ?? 0,
        time: _formatTimeAgo(createdAt),
        caption: record['caption'] as String,
        image: imageUrl,
        likes: _getRelationCount(record['post_likes']),
        comments: _getRelationCount(record['post_comments']),
        createdAt: createdAt,
      );
    }).toList();
  }

  int _getRelationCount(dynamic relation) {
    if (relation is List && relation.isNotEmpty) {
      final first = relation.first;

      if (first is Map) {
        return (first['count'] as num?)?.toInt() ?? 0;
      }
    }

    if (relation is Map) {
      return (relation['count'] as num?)?.toInt() ?? 0;
    }

    return 0;
  }

  String _formatTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);

    if (difference.isNegative || difference.inSeconds < 60) {
      return 'همین الان';
    }

    if (difference.inMinutes < 60) {
      return '${_toPersianDigits(difference.inMinutes)} دقیقه پیش';
    }

    if (difference.inHours < 24) {
      return '${_toPersianDigits(difference.inHours)} ساعت پیش';
    }

    if (difference.inDays < 30) {
      return '${_toPersianDigits(difference.inDays)} روز پیش';
    }

    if (difference.inDays < 365) {
      return '${_toPersianDigits(difference.inDays ~/ 30)} ماه پیش';
    }

    return '${_toPersianDigits(difference.inDays ~/ 365)} سال پیش';
  }

  String _toPersianDigits(int number) {
    const english = '0123456789';
    const persian = '۰۱۲۳۴۵۶۷۸۹';

    return number.toString().split('').map((digit) {
      final index = english.indexOf(digit);
      return index == -1 ? digit : persian[index];
    }).join();
  }

  
  Future<Set<String>> fetchLikedPostIds() async {
    final userId = _client.auth.currentUser?.id;

    if (userId == null) {
      return {};
    }

    final response = await _client
        .from('post_likes')
        .select('record_id')
        .eq('user_id', userId);

    return response
        .map((item) => item['record_id'] as String)
        .toSet();
  }

  Future<bool> toggleLike(String recordId) async {
    final userId = _client.auth.currentUser?.id;

    if (userId == null) {
      throw StateError('User is not authenticated.');
    }

    final existingLike = await _client
        .from('post_likes')
        .select('record_id')
        .eq('user_id', userId)
        .eq('record_id', recordId)
        .maybeSingle();

    if (existingLike != null) {
      await _client
          .from('post_likes')
          .delete()
          .eq('user_id', userId)
          .eq('record_id', recordId);

      return false;
    }

    await _client.from('post_likes').insert({
      'user_id': userId,
      'record_id': recordId,
    });

    return true;
  }

}
