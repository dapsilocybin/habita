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
      'createdAt': createdAt,
      'content': content,
      'userId': userId,
      'recordId': recordId,
    };
  }

  static CommentModel fromMap(Map<String, dynamic> data) {
    return CommentModel(
      id: data['id'] as String,
      createdAt: data['createdAt'] as DateTime,
      content: data['content'] as String,
      userId: data['userId'] as String,
      recordId: data['recordId'] as String,
    );
  }

}
