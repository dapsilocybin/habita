import 'package:equatable/equatable.dart';
import 'habit.dart'; // Replace with the path to your Habit model

class HabitState extends Equatable {
  final List<Habit> habits;
  final bool isLoading;
  final String? error;

  const HabitState({
    required this.habits,
    this.isLoading = false,
    this.error,
  });

  HabitState copyWith({
    List<Habit>? habits,
    bool? isLoading,
    String? error,
  }) {
    return HabitState(
      habits: habits ?? this.habits,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [habits, isLoading, error];
}

// Initial state
class HabitInitialState extends HabitState {
  const HabitInitialState() : super(habits: [], isLoading: false);
}

// Loading state
class HabitLoadingState extends HabitState {
  const HabitLoadingState() : super(habits: [], isLoading: true);
}

// Error state
class HabitErrorState extends HabitState {
  const HabitErrorState(String error)
      : super(habits: [], isLoading: false, error: error);
}
