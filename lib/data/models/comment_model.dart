class CommentModel {
  final String id;
  final DateTime createdAt;
  final String content;
  final String userId;
  final String recordId;

  CommentModel({required this.id, required this.createdAt, required this.content, required this.userId, required this.recordId});

}
