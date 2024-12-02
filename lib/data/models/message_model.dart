class MessageModel {
  final String id;
  final String createdAt;
  final String content;
  final String chatId;
  final String senderId;

  MessageModel({required this.id, required this.createdAt, required this.content, required this.chatId, required this.senderId});

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'content': content,
      'chatId': chatId,
      'senderId': senderId,
    };
  }

  static MessageModel fromMap(Map<String, dynamic> data) {
    return MessageModel(
      id: data['id'] as String,
      createdAt: data['createdAt'] as DateTime,
      content: data['content'] as String,
      chatId: data['chatId'] as String,
      senderId: data['senderId'] as String,
    );
  }
  
}
