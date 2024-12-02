import 'package:equatable/equatable.dart';
import 'package:habita/data/models/habit_model.dart';


class HabitState extends Equatable {
  final List<HabitModel> habits;
  final bool isLoading;
  final String? error;

  const HabitState({
    required this.habits,
    this.isLoading = false,
    this.error,
  });

  HabitState copyWith({
    List<HabitModel>? habits,
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
  HabitInitialState() : super(habits: [], isLoading: false);
}

// Loading state
class HabitLoadingState extends HabitState {
  HabitLoadingState() : super(habits: [], isLoading: true);
}

// Error state
class HabitErrorState extends HabitState {
  HabitErrorState(String error)
      : super(habits: [], isLoading: false, error: error);
}
