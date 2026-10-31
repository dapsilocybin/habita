import 'package:habita/data/models/habit_post_model.dart';
import 'package:habita/data/providers/home_provider.dart';

class HomeRepository {
  final HomeProvider homeProvider;

  HomeRepository({required this.homeProvider});

  Future<List<HabitPost>> fetchPosts() {
    return homeProvider.fetchPosts();
  }

  Future<Set<String>> fetchLikedPostIds() {
    return homeProvider.fetchLikedPostIds();
  }

  Future<bool> toggleLike(String recordId) {
    return homeProvider.toggleLike(recordId);
  }
}
