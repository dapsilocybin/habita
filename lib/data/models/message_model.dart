class MessageModel {
  final String id;
  final DateTime createdAt;
  final String content;
  final String chatId;
  final String senderId;

  MessageModel({required this.id, required this.createdAt, required this.content, required this.chatId, required this.senderId});

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
      'content': content,
      'chat_id': chatId,
      'sender_id': senderId,
    };
  }

  static MessageModel fromMap(Map<String, dynamic> data) {
    return MessageModel(
      id: data['id'] as String,
      createdAt: data['created_at'] as DateTime,
      content: data['content'] as String,
      chatId: data['chat_id'] as String,
      senderId: data['sender_id'] as String,
    );
  }
  
}
