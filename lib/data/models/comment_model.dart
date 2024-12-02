class CommentModel {
  final String id;
  final DateTime createdAt;
  final String content;
  final String userId;
  final String recordId;

  CommentModel({required this.id, required this.createdAt, required this.content, required this.userId, required this.recordId});

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
      'content': content,
      'user_id': userId,
      'record_id': recordId,
    };
  }

  static CommentModel fromMap(Map<String, dynamic> data) {
    return CommentModel(
      id: data['id'] as String,
      createdAt: data['created_at'] as DateTime,
      content: data['content'] as String,
      userId: data['user_id'] as String,
      recordId: data['record_id'] as String,
    );
  }

}
