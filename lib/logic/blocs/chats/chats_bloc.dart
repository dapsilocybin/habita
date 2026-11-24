import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habita/data/repositories/messaging_repository.dart';
import 'chats_event.dart';
import 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc({required this.repository}) : super(const ChatsInitial()) {
    on<ChatsRequested>(_onRequested);
    on<ChatsRefreshed>(_onRefreshed);
    on<ChatsSearchChanged>(_onSearchChanged);
  }

  final MessagingRepository repository;
  String _query = '';

  Future<void> _onRequested(
    ChatsRequested event,
    Emitter<ChatsState> emit,
  ) async {
    emit(const ChatsLoading());
    await _load(emit);
  }

  Future<void> _onRefreshed(
    ChatsRefreshed event,
    Emitter<ChatsState> emit,
  ) async {
    emit(const ChatsLoading());
    await _load(emit);
  }

  Future<void> _load(Emitter<ChatsState> emit) async {
    try {
      final conversations = await repository.fetchConversations();
      emit(ChatsLoaded(conversations: conversations, query: _query));
    } catch (error) {
      emit(ChatsError(error.toString()));
    }
  }

  void _onSearchChanged(ChatsSearchChanged event, Emitter<ChatsState> emit) {
    _query = event.query;
    final current = state;
    if (current is ChatsLoaded) {
      emit(current.copyWith(query: event.query));
    }
  }
}
