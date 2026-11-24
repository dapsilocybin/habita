import 'package:equatable/equatable.dart';
import 'package:habita/data/models/conversation_model.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object?> get props => [];
}

class ChatsInitial extends ChatsState {
  const ChatsInitial();
}

class ChatsLoading extends ChatsState {
  const ChatsLoading();
}

class ChatsLoaded extends ChatsState {
  const ChatsLoaded({required this.conversations, this.query = ''});

  final List<Conversation> conversations;
  final String query;

  List<Conversation> get filteredConversations {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return conversations;
    return conversations.where((conversation) {
      return conversation.otherUser.username.toLowerCase().contains(
            normalized,
          ) ||
          conversation.otherUser.fullName.toLowerCase().contains(normalized);
    }).toList();
  }

  ChatsLoaded copyWith({String? query}) {
    return ChatsLoaded(
      conversations: conversations,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [conversations, query];
}

class ChatsError extends ChatsState {
  const ChatsError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
