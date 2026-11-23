import 'package:equatable/equatable.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object?> get props => [];
}

class CommentsRequested extends CommentsEvent {
  final String recordId;

  const CommentsRequested(this.recordId);

  @override
  List<Object?> get props => [recordId];
}

class CommentSubmitted extends CommentsEvent {
  final String recordId;
  final String content;
  final String? parentCommentId;

  const CommentSubmitted({
    required this.recordId,
    required this.content,
    this.parentCommentId,
  });

  @override
  List<Object?> get props => [recordId, content, parentCommentId];
}

class CommentDeleted extends CommentsEvent {
  final String recordId;
  final String commentId;

  const CommentDeleted({required this.recordId, required this.commentId});

  @override
  List<Object?> get props => [recordId, commentId];
}
