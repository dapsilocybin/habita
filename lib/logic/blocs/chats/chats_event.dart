import 'package:equatable/equatable.dart';

abstract class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object?> get props => [];
}

class ChatsRequested extends ChatsEvent {
  const ChatsRequested();
}

class ChatsRefreshed extends ChatsEvent {
  const ChatsRefreshed();
}

class ChatsSearchChanged extends ChatsEvent {
  const ChatsSearchChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}
