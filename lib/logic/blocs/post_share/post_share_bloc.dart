import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habita/data/models/followed_user_model.dart';
import 'package:habita/data/repositories/post_share_repository.dart';
import 'post_share_event.dart';
import 'post_share_state.dart';

class PostShareBloc extends Bloc<PostShareEvent, PostShareState> {
  final PostShareRepository repository;

  PostShareBloc({required this.repository}) : super(const PostShareInitial()) {
    on<PostShareRecipientsRequested>(_onRecipientsRequested);
    on<PostSharedWithUserRequested>(_onSharedWithUserRequested);
  }

  Future<void> _onRecipientsRequested(
    PostShareRecipientsRequested event,
    Emitter<PostShareState> emit,
  ) async {
    emit(const PostShareRecipientsLoading());
    try {
      final recipients = await repository.fetchFollowedUsers();
      emit(PostShareRecipientsLoaded(recipients));
    } catch (error, stackTrace) {
      debugPrint('Failed to load share recipients: $error');
      debugPrintStack(stackTrace: stackTrace);
      emit(PostShareError(error.toString()));
    }
  }

  Future<void> _onSharedWithUserRequested(
    PostSharedWithUserRequested event,
    Emitter<PostShareState> emit,
  ) async {
    if (state is PostShareSubmitting) return;

    var recipients = const <FollowedUser>[];
    if (state is PostShareRecipientsLoaded) {
      recipients = (state as PostShareRecipientsLoaded).recipients;
    } else if (state is PostShareError) {
      recipients = (state as PostShareError).recipients;
    }

    emit(
      PostShareSubmitting(
        recipients: recipients,
        recipientId: event.recipientId,
      ),
    );

    try {
      await repository.sharePostWithUser(
        recordId: event.recordId,
        recipientId: event.recipientId,
      );
      emit(const PostShareSuccess());
    } catch (error) {
      debugPrint('Failed to share post: $error');
      emit(PostShareError(error.toString(), recipients: recipients));
    }
  }
}
