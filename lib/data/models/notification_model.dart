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
      'createdAt': createdAt,
      'type': type,
      'message': message,
      'isRead': isRead,
      'userId': userId,
    };
  }

  static NotificationModel fromMap(Map<String, dynamic> data) {
    return NotificationModel(
      id: data['id'] as String,
      createdAt: data['createdAt'] as DateTime,
      type: data['type'] as String,
      message: data['message'] as String,
      isRead: data['isRead'] as String,
      userId: data['userId'] as String,
    );
  }
  
}
