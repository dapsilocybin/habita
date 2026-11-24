import 'package:equatable/equatable.dart';

abstract class PostShareEvent extends Equatable {
  const PostShareEvent();

  @override
  List<Object?> get props => [];
}

class PostShareRecipientsRequested extends PostShareEvent {
  const PostShareRecipientsRequested();
}

class PostSharedWithUserRequested extends PostShareEvent {
  final String recordId;
  final String recipientId;

  const PostSharedWithUserRequested({
    required this.recordId,
    required this.recipientId,
  });

  @override
  List<Object?> get props => [recordId, recipientId];
}
