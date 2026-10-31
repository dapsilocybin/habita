import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:habita/data/models/joined_habit_model.dart';

class AddRecordState extends Equatable {
  final String? selectedHabitId;
  final String? selectedHabitName;
  final String caption;
  final Uint8List? imageBytes;
  final String? imageName;
  final String? validationMessage;
  final bool submissionReady;
  final List<JoinedHabit> joinedHabits;
  final bool isLoadingHabits;
  final String? habitsError;
  final bool isSubmitting;
  final bool submissionSuccess;
  final String? submissionError;

  const AddRecordState({
    this.selectedHabitId,
    this.selectedHabitName,
    this.caption = '',
    this.imageBytes,
    this.imageName,
    this.validationMessage,
    this.submissionReady = false,
    this.joinedHabits = const [],
    this.isLoadingHabits = false,
    this.habitsError,
    this.isSubmitting = false,
    this.submissionSuccess = false,
    this.submissionError,
  });

  AddRecordState copyWith({
    String? selectedHabitId,
    String? selectedHabitName,
    bool clearSelectedHabit = false,
    String? caption,
    Uint8List? imageBytes,
    String? imageName,
    bool clearImage = false,
    String? validationMessage,
    bool clearValidationMessage = false,
    bool? submissionReady,
    List<JoinedHabit>? joinedHabits,
    bool? isLoadingHabits,
    String? habitsError,
    bool clearHabitsError = false,
    bool? isSubmitting,
    bool? submissionSuccess,
    String? submissionError,
    bool clearSubmissionError = false,
  }) {
    return AddRecordState(
      selectedHabitId: clearSelectedHabit
          ? null
          : selectedHabitId ?? this.selectedHabitId,
      selectedHabitName: clearSelectedHabit
          ? null
          : selectedHabitName ?? this.selectedHabitName,
      caption: caption ?? this.caption,
      imageBytes: clearImage ? null : imageBytes ?? this.imageBytes,
      imageName: clearImage ? null : imageName ?? this.imageName,
      validationMessage: clearValidationMessage
          ? null
          : validationMessage ?? this.validationMessage,
      submissionReady: submissionReady ?? this.submissionReady,
      joinedHabits: joinedHabits ?? this.joinedHabits,
      isLoadingHabits: isLoadingHabits ?? this.isLoadingHabits,
      habitsError: clearHabitsError ? null : habitsError ?? this.habitsError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submissionSuccess: submissionSuccess ?? this.submissionSuccess,
      submissionError: clearSubmissionError
          ? null
          : submissionError ?? this.submissionError,
    );
  }

  @override
  List<Object?> get props => [
    selectedHabitId,
    selectedHabitName,
    caption,
    imageBytes,
    imageName,
    validationMessage,
    submissionReady,
    joinedHabits,
    isLoadingHabits,
    habitsError,
    isSubmitting,
    submissionSuccess,
    submissionError,
  ];
}
