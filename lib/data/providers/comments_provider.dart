import 'package:habita/data/models/post_comment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommentsProvider {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<PostComment>> fetchComments(String recordId) async {
    final rows = await _client
        .from('post_comments')
        .select('''
          id,
          record_id,
          user_id,
          parent_comment_id,
          content,
          created_at,
          deleted_at,
          profiles!post_comments_user_id_fkey (
            username,
            full_name
          )
        ''')
        .eq('record_id', recordId)
        .order('created_at', ascending: true);

    final comments = rows.map((row) => PostComment.fromMap(row)).toList();
    final commentsById = {for (final comment in comments) comment.id: comment};
    final repliesByParent = <String, List<PostComment>>{};
    final roots = <PostComment>[];

    for (final comment in comments) {
      final parentId = comment.parentCommentId;
      if (parentId != null && commentsById.containsKey(parentId)) {
        repliesByParent.putIfAbsent(parentId, () => []).add(comment);
      } else {
        roots.add(comment);
      }
    }

    PostComment nest(PostComment comment) {
      final replies = repliesByParent[comment.id] ?? const <PostComment>[];
      return comment.copyWith(replies: replies.map(nest).toList());
    }

    return roots.map(nest).toList();
  }

  Future<void> addComment({
    required String recordId,
    required String content,
    String? parentCommentId,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw StateError('User is not authenticated.');
    }

    await _client.from('post_comments').insert({
      'record_id': recordId,
      'user_id': userId,
      'parent_comment_id': parentCommentId,
      'content': content.trim(),
    });
  }

  Future<void> softDeleteComment(String commentId) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw StateError('User is not authenticated.');
    }

    final deleted = await _client
        .from('post_comments')
        .update({'deleted_at': DateTime.now().toUtc().toIso8601String()})
        .eq('id', commentId)
        .eq('user_id', userId)
        .isFilter('deleted_at', null)
        .select('id')
        .maybeSingle();

    if (deleted == null) {
      throw StateError('Comment is unavailable or cannot be deleted.');
    }
  }
}
