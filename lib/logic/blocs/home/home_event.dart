
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

/// Load the initial Home feed.
class HomeFeedRequested extends HomeEvent {
  const HomeFeedRequested();
}

/// Refresh the Home feed.
class HomeFeedRefreshed extends HomeEvent {
  const HomeFeedRefreshed();
}

/// Like or unlike a post.
class HomePostLikeToggled extends HomeEvent {
  final String postId;

  const HomePostLikeToggled(this.postId);

  @override
  List<Object?> get props => [postId];
}
