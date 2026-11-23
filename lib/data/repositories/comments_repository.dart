import 'package:habita/data/models/post_comment_model.dart';
import 'package:habita/data/providers/comments_provider.dart';

class CommentsRepository {
  final CommentsProvider commentsProvider;

  CommentsRepository({required this.commentsProvider});

  Future<List<PostComment>> fetchComments(String recordId) {
    return commentsProvider.fetchComments(recordId);
  }

  Future<void> addComment({
    required String recordId,
    required String content,
    String? parentCommentId,
  }) {
    return commentsProvider.addComment(
      recordId: recordId,
      content: content,
      parentCommentId: parentCommentId,
    );
  }

  Future<void> softDeleteComment(String commentId) {
    return commentsProvider.softDeleteComment(commentId);
  }
}
