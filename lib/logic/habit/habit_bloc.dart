import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/habit_repository.dart';
import 'habit_event.dart';
import 'habit_state.dart';


class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final HabitRepository repository;

  HabitBloc(this.repository) : super(HabitInitialState()) {
    // Event handling
    on<LoadHabits>(_onLoadHabits);
    on<AddHabit>(_onAddHabit);
  }

  Future<void> _onLoadHabits(LoadHabits event, Emitter<HabitState> emit) async {
    emit(HabitLoadingState());
    try {
      final habits = await repository.getAllHabits();
      emit(HabitState(habits: habits, isLoading: false));
    } catch (e) {
      emit(HabitErrorState(e.toString()));
    }
  }

  Future<void> _onAddHabit(AddHabit event, Emitter<HabitState> emit) async {
    try {
      await repository.addHabit(event.habit);
      // Refresh the habit list after adding
      add(LoadHabits());
    } catch (e) {
      emit(HabitErrorState(e.toString()));
    }
  }
}
