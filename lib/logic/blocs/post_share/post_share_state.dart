import 'package:equatable/equatable.dart';
import 'package:habita/data/models/followed_user_model.dart';

abstract class PostShareState extends Equatable {
  const PostShareState();

  @override
  List<Object?> get props => [];
}

class PostShareInitial extends PostShareState {
  const PostShareInitial();
}

class PostShareRecipientsLoading extends PostShareState {
  const PostShareRecipientsLoading();
}

class PostShareRecipientsLoaded extends PostShareState {
  final List<FollowedUser> recipients;

  const PostShareRecipientsLoaded(this.recipients);

  @override
  List<Object?> get props => [recipients];
}

class PostShareSubmitting extends PostShareState {
  final List<FollowedUser> recipients;
  final String recipientId;

  const PostShareSubmitting({
    required this.recipients,
    required this.recipientId,
  });

  @override
  List<Object?> get props => [recipients, recipientId];
}

class PostShareSuccess extends PostShareState {
  const PostShareSuccess();
}

class PostShareError extends PostShareState {
  final String message;
  final List<FollowedUser> recipients;

  const PostShareError(this.message, {this.recipients = const []});

  @override
  List<Object?> get props => [message, recipients];
}
