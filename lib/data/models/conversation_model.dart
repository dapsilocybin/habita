import 'chat_user_model.dart';

class Conversation {
  const Conversation({
    required this.id,
    required this.otherUser,
    required this.updatedAt,
    this.latestMessage = '',
    this.latestMessageType = 'text',
    this.latestSharedRecordId,
  });

  final String id;
  final ChatUser otherUser;
  final DateTime updatedAt;
  final String latestMessage;
  final String latestMessageType;
  final String? latestSharedRecordId;

  String get previewText => latestMessageType == 'shared_post'
      ? 'یک پست را به اشتراک گذاشت'
      : latestMessage;
}
