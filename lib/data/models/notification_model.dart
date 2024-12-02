class NotificationModel {
  final String id;
  final DateTime createdAt;
  final String type;
  final String message;
  final bool isRead;
  final String userId;

  NotificationModel({required this.id, required this.createdAt, required this.type, required this.message, required this.isRead, required this.userId});

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
      'type': type,
      'message': message,
      'is_read': isRead,
      'user_id': userId,
    };
  }

  static NotificationModel fromMap(Map<String, dynamic> data) {
    return NotificationModel(
      id: data['id'] as String,
      createdAt: data['created_at'] as DateTime,
      type: data['type'] as String,
      message: data['message'] as String,
      isRead: data['is_read'] as bool,
      userId: data['user_id'] as String,
    );
  }
  
}
