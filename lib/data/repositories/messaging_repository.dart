import 'package:habita/data/models/chat_message_model.dart';
import 'package:habita/data/models/conversation_model.dart';
import 'package:habita/data/providers/messaging_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessagingRepository {
  MessagingRepository({required this.provider});

  final MessagingProvider provider;

  Future<List<Conversation>> fetchConversations() {
    return provider.fetchConversations();
  }

  Future<List<ChatMessage>> fetchMessages(String conversationId) {
    return provider.fetchMessages(conversationId);
  }

  Future<void> sendMessage({
    required String conversationId,
    required String content,
  }) {
    return provider.sendMessage(
      conversationId: conversationId,
      content: content,
    );
  }

  RealtimeChannel subscribeToMessages({
    required String conversationId,
    required void Function() onChanged,
    required void Function(String message) onError,
  }) {
    return provider.subscribeToMessages(
      conversationId: conversationId,
      onChanged: onChanged,
      onError: onError,
    );
  }

  Future<void> removeChannel(RealtimeChannel channel) {
    return provider.removeChannel(channel);
  }
}
