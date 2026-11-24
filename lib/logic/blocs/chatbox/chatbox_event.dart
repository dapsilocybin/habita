import 'package:equatable/equatable.dart';

abstract class ChatboxEvent extends Equatable {
  const ChatboxEvent();

  @override
  List<Object?> get props => [];
}

class ChatboxMessagesRequested extends ChatboxEvent {
  const ChatboxMessagesRequested(this.conversationId);

  final String conversationId;

  @override
  List<Object?> get props => [conversationId];
}

class ChatboxMessagesRefreshed extends ChatboxEvent {
  const ChatboxMessagesRefreshed();
}

class ChatboxRealtimeMessageReceived extends ChatboxEvent {
  const ChatboxRealtimeMessageReceived();
}

class ChatboxRealtimeErrorReceived extends ChatboxEvent {
  const ChatboxRealtimeErrorReceived(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class ChatboxMessageSendRequested extends ChatboxEvent {
  const ChatboxMessageSendRequested(this.content);

  final String content;

  @override
  List<Object?> get props => [content];
}
