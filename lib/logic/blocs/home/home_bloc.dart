
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habita/data/repositories/home_repository.dart';
import 'package:habita/logic/blocs/home/home_event.dart';
import 'package:habita/logic/blocs/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(const HomeInitial()) {
    on<HomeFeedRequested>(_onFeedRequested);
    on<HomeFeedRefreshed>(_onFeedRefreshed);
    on<HomePostLikeToggled>(_onPostLikeToggled);
  }

  
  Future<void> _loadFeed(Emitter<HomeState> emit) async {
    final postsFuture = homeRepository.fetchPosts();
    final likedIdsFuture = homeRepository.fetchLikedPostIds();

    final posts = await postsFuture;
    final likedPostIds = await likedIdsFuture;

    emit(
      HomeLoaded(
        posts: posts,
        likedPostIds: likedPostIds,
      ),
    );
  }

  Future<void> _onFeedRequested(
    HomeFeedRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());

    try {
      await _loadFeed(emit);
    } catch (error) {
      emit(HomeError(error.toString()));
    }
  }

  Future<void> _onFeedRefreshed(
    HomeFeedRefreshed event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await _loadFeed(emit);
    } catch (error) {
      emit(HomeError(error.toString()));
    }
  }

  Future<void> _onPostLikeToggled(
    HomePostLikeToggled event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;

    if (currentState is! HomeLoaded) return;

    final postIndex = currentState.posts.indexWhere(
      (post) => post.id == event.postId,
    );

    if (postIndex == -1) return;

    try {
      final isLiked = await homeRepository.toggleLike(event.postId);

      // Use the latest state in case another event changed the feed
      // while the database request was running.
      final latestState = state;

      if (latestState is! HomeLoaded) return;

      final latestPostIndex = latestState.posts.indexWhere(
        (post) => post.id == event.postId,
      );

      if (latestPostIndex == -1) return;

      final updatedPosts = List.of(latestState.posts);
      final post = updatedPosts[latestPostIndex];

      final updatedLikedIds = Set<String>.from(
        latestState.likedPostIds,
      );

      final wasLiked = updatedLikedIds.contains(event.postId);

      if (isLiked) {
        updatedLikedIds.add(event.postId);
      } else {
        updatedLikedIds.remove(event.postId);
      }

      // Only adjust the count if the state actually changed.
      final countDifference = isLiked == wasLiked
          ? 0
          : (isLiked ? 1 : -1);

      updatedPosts[latestPostIndex] = post.copyWith(
        likes: (post.likes + countDifference).clamp(0, 1 << 31),
      );

      emit(
        latestState.copyWith(
          posts: updatedPosts,
          likedPostIds: updatedLikedIds,
        ),
      );
    } catch (error) {
      debugPrint('Failed to toggle post like: $error');
    }
  }
}
