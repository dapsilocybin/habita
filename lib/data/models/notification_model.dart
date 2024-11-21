class NotificationModel {
  final String id;
  final DateTime createdAt;
  final String type;
  final String message;
  final bool isRead;
  final String userId;

  NotificationModel({required this.id, required this.createdAt, required this.type, required this.message, required this.isRead, required this.userId});
}
