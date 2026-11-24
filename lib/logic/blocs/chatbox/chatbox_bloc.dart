import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habita/data/models/chat_message_model.dart';
import 'package:habita/data/repositories/messaging_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'chatbox_event.dart';
import 'chatbox_state.dart';

class ChatboxBloc extends Bloc<ChatboxEvent, ChatboxState> {
  ChatboxBloc({required this.repository}) : super(const ChatboxInitial()) {
    on<ChatboxMessagesRequested>(_onRequested);
    on<ChatboxMessagesRefreshed>(_onRefreshed);
    on<ChatboxRealtimeMessageReceived>(_onRealtimeMessageReceived);
    on<ChatboxRealtimeErrorReceived>(_onRealtimeErrorReceived);
    on<ChatboxMessageSendRequested>(_onSendRequested);
  }

  final MessagingRepository repository;
  String? _conversationId;
  RealtimeChannel? _channel;
  bool _isSending = false;
  String? _realtimeError;

  Future<void> _onRequested(
    ChatboxMessagesRequested event,
    Emitter<ChatboxState> emit,
  ) async {
    _conversationId = event.conversationId;
    emit(const ChatboxLoading());
    try {
      final oldChannel = _channel;
      if (oldChannel != null) {
        await repository.removeChannel(oldChannel);
        _channel = null;
      }
      _realtimeError = null;
      final messages = await repository.fetchMessages(event.conversationId);
      emit(ChatboxLoaded(messages: messages));
      _channel = repository.subscribeToMessages(
        conversationId: event.conversationId,
        onChanged: () => add(const ChatboxRealtimeMessageReceived()),
        onError: (message) {
          add(ChatboxRealtimeErrorReceived(message));
        },
      );
    } catch (error) {
      emit(ChatboxError(error.toString()));
    }
  }

  Future<void> _onRefreshed(
    ChatboxMessagesRefreshed event,
    Emitter<ChatboxState> emit,
  ) async {
    await _reload(emit, isRefreshing: true);
  }

  Future<void> _onRealtimeMessageReceived(
    ChatboxRealtimeMessageReceived event,
    Emitter<ChatboxState> emit,
  ) async {
    await _reload(emit);
  }

  void _onRealtimeErrorReceived(
    ChatboxRealtimeErrorReceived event,
    Emitter<ChatboxState> emit,
  ) {
    _realtimeError = event.message;
    debugPrint('Chat Realtime unavailable: ${event.message}');
    final current = state;
    if (current is ChatboxLoaded) {
      emit(
        ChatboxLoaded(
          messages: current.messages,
          isSending: current.isSending,
          error: current.error,
          realtimeError: event.message,
        ),
      );
    }
  }

  Future<void> _reload(
    Emitter<ChatboxState> emit, {
    bool isRefreshing = false,
  }) async {
    final conversationId = _conversationId;
    if (conversationId == null) return;
    final previous = state;
    final messages = previous is ChatboxLoaded
        ? previous.messages
        : const <ChatMessage>[];
    if (isRefreshing) {
      emit(
        ChatboxLoaded(
          messages: messages,
          isSending: _isSending,
          isRefreshing: true,
          realtimeError: _realtimeError,
        ),
      );
    }
    try {
      final updated = await repository.fetchMessages(conversationId);
      emit(
        ChatboxLoaded(
          messages: updated,
          isSending: _isSending,
          isRefreshing: false,
          realtimeError: _realtimeError,
        ),
      );
    } catch (error) {
      emit(
        ChatboxLoaded(
          messages: messages,
          isSending: _isSending,
          isRefreshing: false,
          error: error.toString(),
          realtimeError: _realtimeError,
        ),
      );
    }
  }

  Future<void> _onSendRequested(
    ChatboxMessageSendRequested event,
    Emitter<ChatboxState> emit,
  ) async {
    final conversationId = _conversationId;
    final content = event.content.trim();
    if (_isSending || conversationId == null || content.isEmpty) return;

    final previous = state;
    final previousMessages = previous is ChatboxLoaded
        ? previous.messages
        : const <ChatMessage>[];
    _isSending = true;
    emit(
      ChatboxLoaded(
        messages: previousMessages,
        isSending: true,
        realtimeError: _realtimeError,
      ),
    );

    try {
      await repository.sendMessage(
        conversationId: conversationId,
        content: content,
      );
      final messages = await repository.fetchMessages(conversationId);
      emit(ChatboxLoaded(messages: messages, realtimeError: _realtimeError));
    } catch (error) {
      emit(
        ChatboxLoaded(
          messages: previousMessages,
          error: error.toString(),
          realtimeError: _realtimeError,
        ),
      );
    } finally {
      _isSending = false;
    }
  }

  @override
  Future<void> close() async {
    final channel = _channel;
    if (channel != null) {
      await repository.removeChannel(channel);
    }
    return super.close();
  }
}
