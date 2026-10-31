import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habita/data/repositories/add_record_repository.dart';
import 'package:habita/logic/blocs/add_record/add_record_event.dart';
import 'package:habita/logic/blocs/add_record/add_record_state.dart';

class AddRecordBloc extends Bloc<AddRecordEvent, AddRecordState> {
  final AddRecordRepository addRecordRepository;

  AddRecordBloc({required this.addRecordRepository})
    : super(const AddRecordState()) {
    on<AddRecordHabitsRequested>(_onHabitsRequested);
    on<AddRecordHabitSelected>(_onHabitSelected);
    on<AddRecordCaptionChanged>(_onCaptionChanged);
    on<AddRecordImageSelected>(_onImageSelected);
    on<AddRecordImageRemoved>(_onImageRemoved);
    on<AddRecordSubmitted>(_onSubmitted);
  }

  Future<void> _onHabitsRequested(
    AddRecordHabitsRequested event,
    Emitter<AddRecordState> emit,
  ) async {
    emit(state.copyWith(isLoadingHabits: true, clearHabitsError: true));

    try {
      final habits = await addRecordRepository.fetchJoinedHabits();

      emit(
        state.copyWith(
          joinedHabits: habits,
          isLoadingHabits: false,
          clearHabitsError: true,
        ),
      );
    } catch (error, stackTrace) {
      debugPrint('Failed to fetch joined habits: $error');
      debugPrintStack(stackTrace: stackTrace);

      emit(
        state.copyWith(
          isLoadingHabits: false,
          habitsError: 'دریافت عادت‌ها با مشکل مواجه شد.',
        ),
      );
    }
  }

  void _onHabitSelected(
    AddRecordHabitSelected event,
    Emitter<AddRecordState> emit,
  ) {
    emit(
      state.copyWith(
        selectedHabitId: event.habitId,
        selectedHabitName: event.habitName,
        clearValidationMessage: true,
        submissionReady: false,
        submissionSuccess: false,
        clearSubmissionError: true,
      ),
    );
  }

  void _onCaptionChanged(
    AddRecordCaptionChanged event,
    Emitter<AddRecordState> emit,
  ) {
    emit(
      state.copyWith(
        caption: event.caption,
        clearValidationMessage: true,
        submissionReady: false,
        submissionSuccess: false,
        clearSubmissionError: true,
      ),
    );
  }

  void _onImageSelected(
    AddRecordImageSelected event,
    Emitter<AddRecordState> emit,
  ) {
    emit(
      state.copyWith(
        imageBytes: event.imageBytes,
        imageName: event.imageName,
        clearValidationMessage: true,
        submissionReady: false,
        submissionSuccess: false,
        clearSubmissionError: true,
      ),
    );
  }

  void _onImageRemoved(
    AddRecordImageRemoved event,
    Emitter<AddRecordState> emit,
  ) {
    emit(
      state.copyWith(
        clearImage: true,
        clearValidationMessage: true,
        submissionReady: false,
        submissionSuccess: false,
        clearSubmissionError: true,
      ),
    );
  }

  Future<void> _onSubmitted(
    AddRecordSubmitted event,
    Emitter<AddRecordState> emit,
  ) async {
    if (state.isSubmitting) return;

    if (state.selectedHabitId == null) {
      emit(
        state.copyWith(
          validationMessage: 'ابتدا یک عادت انتخاب کن.',
          submissionReady: false,
        ),
      );
      return;
    }

    if (state.caption.trim().isEmpty) {
      emit(
        state.copyWith(
          validationMessage: 'نوشتن توضیحات تلاش الزامی است.',
          submissionReady: false,
        ),
      );
      return;
    }

    final habitId = state.selectedHabitId!;
    final matchingHabits = state.joinedHabits.where(
      (habit) => habit.id == habitId,
    );

    if (matchingHabits.isEmpty) {
      emit(
        state.copyWith(
          validationMessage: 'عادت انتخاب‌شده پیدا نشد. دوباره انتخابش کن.',
          submissionReady: false,
        ),
      );
      return;
    }
    final habit = matchingHabits.first;

    final caption = state.caption.trim();
    final imageBytes = state.imageBytes;
    final imageName = state.imageName;

    emit(
      state.copyWith(
        isSubmitting: true,
        submissionSuccess: false,
        clearSubmissionError: true,
        clearValidationMessage: true,
        submissionReady: false,
      ),
    );

    try {
      await addRecordRepository.publishRecord(
        habitId: habitId,
        caption: caption,
        frequencyLabel: habit.frequencyLabel,
        imageBytes: imageBytes,
        imageName: imageName,
      );

      emit(
        state.copyWith(
          clearSelectedHabit: true,
          caption: '',
          clearImage: true,
          isSubmitting: false,
          submissionSuccess: true,
          clearSubmissionError: true,
          clearValidationMessage: true,
          submissionReady: false,
        ),
      );
    } catch (error, stackTrace) {
      debugPrint('Failed to publish habit record: $error');
      debugPrintStack(stackTrace: stackTrace);

      emit(
        state.copyWith(
          isSubmitting: false,
          submissionSuccess: false,
          submissionError: 'ثبت تلاش با مشکل مواجه شد. لطفاً دوباره تلاش کن.',
          clearValidationMessage: true,
          submissionReady: false,
        ),
      );
    }
  }
}
