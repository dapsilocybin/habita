import 'package:equatable/equatable.dart';
import 'package:habita/data/models/chat_message_model.dart';

abstract class ChatboxState extends Equatable {
  const ChatboxState();

  @override
  List<Object?> get props => [];
}

class ChatboxInitial extends ChatboxState {
  const ChatboxInitial();
}

class ChatboxLoading extends ChatboxState {
  const ChatboxLoading();
}

class ChatboxLoaded extends ChatboxState {
  const ChatboxLoaded({
    required this.messages,
    this.isSending = false,
    this.isRefreshing = false,
    this.error,
    this.realtimeError,
  });

  final List<ChatMessage> messages;
  final bool isSending;
  final bool isRefreshing;
  final String? error;
  final String? realtimeError;

  @override
  List<Object?> get props => [
    messages,
    isSending,
    isRefreshing,
    error,
    realtimeError,
  ];
}

class ChatboxError extends ChatboxState {
  const ChatboxError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
