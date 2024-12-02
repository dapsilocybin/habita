import 'package:equatable/equatable.dart';

abstract class HabitEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Event to load habits
class LoadHabits extends HabitEvent {}

// Event to add a new habit
class AddHabit extends HabitEvent {
  final Habit habit;

  AddHabit(this.habit);

  @override
  List<Object?> get props => [habit];
}
