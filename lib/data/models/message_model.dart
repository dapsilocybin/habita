class MessageModel {
  final String id;
  final String createdAt;
  final String content;
  final String chatId;
  final String senderId;

  MessageModel({required this.id, required this.createdAt, required this.content, required this.chatId, required this.senderId});
}
