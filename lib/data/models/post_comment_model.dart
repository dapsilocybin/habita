class PostComment {
  final String id;
  final String recordId;
  final String userId;
  final String? parentCommentId;
  final String username;
  final String fullName;
  final String content;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final List<PostComment> replies;

  const PostComment({
    required this.id,
    required this.recordId,
    required this.userId,
    required this.parentCommentId,
    required this.username,
    required this.fullName,
    required this.content,
    required this.createdAt,
    required this.deletedAt,
    this.replies = const [],
  });

  bool get isDeleted => deletedAt != null;

  String get displayName => fullName.trim().isNotEmpty
      ? fullName
      : username.trim().isNotEmpty
      ? username
      : 'کاربر';

  factory PostComment.fromMap(Map<String, dynamic> map) {
    final profile = map['profiles'] as Map<String, dynamic>? ?? const {};

    return PostComment(
      id: map['id'] as String,
      recordId: map['record_id'] as String,
      userId: map['user_id'] as String,
      parentCommentId: map['parent_comment_id'] as String?,
      username: profile['username'] as String? ?? '',
      fullName: profile['full_name'] as String? ?? '',
      content: map['content'] as String? ?? '',
      createdAt: DateTime.parse(map['created_at'] as String).toLocal(),
      deletedAt: switch (map['deleted_at']) {
        final String value => DateTime.parse(value).toLocal(),
        _ => null,
      },
    );
  }

  PostComment copyWith({List<PostComment>? replies}) {
    return PostComment(
      id: id,
      recordId: recordId,
      userId: userId,
      parentCommentId: parentCommentId,
      username: username,
      fullName: fullName,
      content: content,
      createdAt: createdAt,
      deletedAt: deletedAt,
      replies: replies ?? this.replies,
    );
  }
}
