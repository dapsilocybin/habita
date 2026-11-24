class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    required this.messageType,
    required this.createdAt,
    this.sharedRecordId,
  });

  final String id;
  final String conversationId;
  final String senderId;
  final String content;
  final String messageType;
  final String? sharedRecordId;
  final DateTime createdAt;

  bool get isSharedPost => messageType == 'shared_post';

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] as String,
      conversationId: map['conversation_id'] as String,
      senderId: map['sender_id'] as String,
      content: map['content'] as String? ?? '',
      messageType: map['message_type'] as String? ?? 'text',
      sharedRecordId: map['shared_record_id'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String).toLocal(),
    );
  }
}
