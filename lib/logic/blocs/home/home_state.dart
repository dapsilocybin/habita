import 'package:equatable/equatable.dart';
import 'package:habita/data/models/habit_post_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<HabitPost> posts;
  final Set<String> likedPostIds;

  const HomeLoaded({required this.posts, this.likedPostIds = const {}});

  HomeLoaded copyWith({List<HabitPost>? posts, Set<String>? likedPostIds}) {
    return HomeLoaded(
      posts: posts ?? this.posts,
      likedPostIds: likedPostIds ?? this.likedPostIds,
    );
  }

  @override
  List<Object?> get props => [posts, likedPostIds];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
