import 'package:equatable/equatable.dart';
import 'package:habita/data/models/post_comment_model.dart';

class CommentsState extends Equatable {
  final List<PostComment> comments;
  final bool isLoading;
  final bool isSubmitting;
  final bool submissionSucceeded;
  final String? error;
  final String? submissionError;

  const CommentsState({
    this.comments = const [],
    this.isLoading = false,
    this.isSubmitting = false,
    this.submissionSucceeded = false,
    this.error,
    this.submissionError,
  });

  CommentsState copyWith({
    List<PostComment>? comments,
    bool? isLoading,
    bool? isSubmitting,
    bool? submissionSucceeded,
    String? error,
    bool clearError = false,
    String? submissionError,
    bool clearSubmissionError = false,
  }) {
    return CommentsState(
      comments: comments ?? this.comments,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submissionSucceeded: submissionSucceeded ?? this.submissionSucceeded,
      error: clearError ? null : error ?? this.error,
      submissionError: clearSubmissionError
          ? null
          : submissionError ?? this.submissionError,
    );
  }

  @override
  List<Object?> get props => [
    comments,
    isLoading,
    isSubmitting,
    submissionSucceeded,
    error,
    submissionError,
  ];
}
