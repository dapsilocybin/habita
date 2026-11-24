import 'package:habita/data/models/followed_user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostShareProvider {
  final SupabaseClient _client;

  PostShareProvider({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  Future<List<FollowedUser>> fetchFollowedUsers() async {
    final currentUserId = _client.auth.currentUser?.id;

    if (currentUserId == null) {
      throw StateError('User is not authenticated.');
    }

    final follows = await _client
        .from('user_follows')
        .select('followed_id')
        .eq('follower_id', currentUserId);

    final ids = follows
        .map((row) => row['followed_id'] as String?)
        .whereType<String>()
        .toSet()
        .toList();

    if (ids.isEmpty) return [];

    final profiles = await _client
        .from('profiles')
        .select('id, username, full_name')
        .inFilter('id', ids);

    return profiles.map((profile) => FollowedUser.fromMap(profile)).toList();
  }

  Future<void> sharePostWithUser({
    required String recordId,
    required String recipientId,
  }) async {
    await _client.rpc(
      'share_post_with_user',
      params: {'p_record_id': recordId, 'p_recipient_id': recipientId},
    );
  }
}
