import 'package:habita/data/models/chat_message_model.dart';
import 'package:habita/data/models/chat_user_model.dart';
import 'package:habita/data/models/conversation_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessagingProvider {
  MessagingProvider({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  Future<List<Conversation>> fetchConversations() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw StateError('User is not authenticated.');
    }

    final membershipRows = await _client
        .from('conversation_participants')
        .select('conversation_id, user_id')
        .eq('user_id', userId);

    final conversationIds = membershipRows
        .map((row) => row['conversation_id'] as String?)
        .whereType<String>()
        .toSet()
        .toList();
    if (conversationIds.isEmpty) return [];

    final conversations = await _client
        .from('conversations')
        .select('id, updated_at')
        .inFilter('id', conversationIds)
        .order('updated_at', ascending: false);

    final participants = await _client
        .from('conversation_participants')
        .select('conversation_id, user_id')
        .inFilter('conversation_id', conversationIds);

    final otherUserByConversation = <String, String>{};
    for (final participant in participants) {
      final conversationId = participant['conversation_id'] as String?;
      final participantId = participant['user_id'] as String?;
      if (conversationId != null &&
          participantId != null &&
          participantId != userId) {
        otherUserByConversation.putIfAbsent(
          conversationId,
          () => participantId,
        );
      }
    }

    final otherUserIds = otherUserByConversation.values.toSet().toList();
    if (otherUserIds.isEmpty) return [];

    final profiles = await _client
        .from('profiles')
        .select('id, username, full_name')
        .inFilter('id', otherUserIds);
    final profileById = <String, ChatUser>{
      for (final profile in profiles)
        profile['id'] as String: ChatUser(
          id: profile['id'] as String,
          username: profile['username'] as String? ?? '',
          fullName: profile['full_name'] as String? ?? '',
        ),
    };

    final latestMessages = await _client
        .from('messages')
        .select(
          'conversation_id, content, message_type, shared_record_id, created_at',
        )
        .inFilter('conversation_id', conversationIds)
        .order('created_at', ascending: false);

    final latestMessageByConversation = <String, Map<String, dynamic>>{};
    for (final message in latestMessages) {
      final conversationId = message['conversation_id'] as String?;
      if (conversationId != null) {
        latestMessageByConversation.putIfAbsent(conversationId, () => message);
      }
    }

    final results = <Conversation>[];
    final seenIds = <String>{};
    final seenOtherUserIds = <String>{};
    for (final row in conversations) {
      final id = row['id'] as String;
      if (!seenIds.add(id)) continue;
      final otherId = otherUserByConversation[id];
      if (otherId == null || !seenOtherUserIds.add(otherId)) continue;
      final otherUser = profileById[otherId];
      if (otherUser == null) continue;

      final latestMessage = latestMessageByConversation[id];
      results.add(
        Conversation(
          id: id,
          otherUser: otherUser,
          updatedAt: DateTime.parse(row['updated_at'] as String).toLocal(),
          latestMessage: latestMessage?['content'] as String? ?? '',
          latestMessageType:
              latestMessage?['message_type'] as String? ?? 'text',
          latestSharedRecordId: latestMessage?['shared_record_id'] as String?,
        ),
      );
    }
    results.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return results;
  }

  Future<List<ChatMessage>> fetchMessages(String conversationId) async {
    final rows = await _client
        .from('messages')
        .select(
          'id, conversation_id, sender_id, content, message_type, '
          'shared_record_id, created_at',
        )
        .eq('conversation_id', conversationId)
        .order('created_at', ascending: true);

    return rows.map(ChatMessage.fromMap).toList();
  }

  Future<void> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw StateError('User is not authenticated.');
    }

    await _client.rpc(
      'send_message',
      params: {'p_conversation_id': conversationId, 'p_content': content},
    );
  }

  RealtimeChannel subscribeToMessages({
    required String conversationId,
    required void Function() onChanged,
    required void Function(String message) onError,
  }) {
    final channel = _client
        .channel('conversation:$conversationId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'messages',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'conversation_id',
            value: conversationId,
          ),
          callback: (_) => onChanged(),
        );

    channel.subscribe((status, error) {
      if (status == RealtimeSubscribeStatus.channelError ||
          status == RealtimeSubscribeStatus.timedOut) {
        onError(error?.toString() ?? 'Realtime subscription failed: $status');
      }
    });
    return channel;
  }

  Future<void> removeChannel(RealtimeChannel channel) {
    return _client.removeChannel(channel);
  }
}
