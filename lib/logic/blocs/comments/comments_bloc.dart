import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habita/data/repositories/comments_repository.dart';
import 'package:habita/logic/blocs/comments/comments_event.dart';
import 'package:habita/logic/blocs/comments/comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final CommentsRepository commentsRepository;

  CommentsBloc({required this.commentsRepository})
    : super(const CommentsState(isLoading: true)) {
    on<CommentsRequested>(_onRequested);
    on<CommentSubmitted>(_onSubmitted);
    on<CommentDeleted>(_onDeleted);
  }

  Future<void> _onRequested(
    CommentsRequested event,
    Emitter<CommentsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final comments = await commentsRepository.fetchComments(event.recordId);
      emit(
        state.copyWith(comments: comments, isLoading: false, clearError: true),
      );
    } catch (error, stackTrace) {
      debugPrint('Failed to fetch comments: $error');
      debugPrintStack(stackTrace: stackTrace);
      emit(state.copyWith(isLoading: false, error: 'دریافت نظرات ناموفق بود.'));
    }
  }

  Future<void> _onSubmitted(
    CommentSubmitted event,
    Emitter<CommentsState> emit,
  ) async {
    if (state.isSubmitting) return;

    final content = event.content.trim();
    if (content.isEmpty) return;

    emit(
      state.copyWith(
        isSubmitting: true,
        submissionSucceeded: false,
        clearSubmissionError: true,
      ),
    );

    try {
      await commentsRepository.addComment(
        recordId: event.recordId,
        content: content,
        parentCommentId: event.parentCommentId,
      );
    } catch (error, stackTrace) {
      debugPrint('Failed to submit comment: $error');
      debugPrintStack(stackTrace: stackTrace);
      emit(
        state.copyWith(
          isSubmitting: false,
          submissionError: 'ثبت نظر ناموفق بود. دوباره تلاش کن.',
        ),
      );
      return;
    }

    try {
      final comments = await commentsRepository.fetchComments(event.recordId);
      emit(
        state.copyWith(
          comments: comments,
          isSubmitting: false,
          submissionSucceeded: true,
          clearError: true,
          clearSubmissionError: true,
        ),
      );
    } catch (error, stackTrace) {
      debugPrint('Comment was submitted but refresh failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      emit(
        state.copyWith(
          isSubmitting: false,
          submissionSucceeded: true,
          error: 'نظر ثبت شد، اما دریافت دوباره نظرات ناموفق بود.',
        ),
      );
    }
  }

  Future<void> _onDeleted(
    CommentDeleted event,
    Emitter<CommentsState> emit,
  ) async {
    if (state.isSubmitting) return;

    emit(
      state.copyWith(
        isSubmitting: true,
        submissionSucceeded: false,
        clearSubmissionError: true,
      ),
    );

    try {
      await commentsRepository.softDeleteComment(event.commentId);
      final comments = await commentsRepository.fetchComments(event.recordId);
      emit(
        state.copyWith(
          comments: comments,
          isSubmitting: false,
          clearError: true,
          clearSubmissionError: true,
        ),
      );
    } catch (error, stackTrace) {
      debugPrint('Failed to delete comment: $error');
      debugPrintStack(stackTrace: stackTrace);
      emit(
        state.copyWith(
          isSubmitting: false,
          submissionError: 'حذف نظر ناموفق بود. دوباره تلاش کن.',
        ),
      );
    }
  }
}
