import 'package:habita/data/models/followed_user_model.dart';
import 'package:habita/data/providers/post_share_provider.dart';

class PostShareRepository {
  final PostShareProvider provider;

  PostShareRepository({required this.provider});

  Future<List<FollowedUser>> fetchFollowedUsers() {
    return provider.fetchFollowedUsers();
  }

  Future<void> sharePostWithUser({
    required String recordId,
    required String recipientId,
  }) {
    return provider.sharePostWithUser(
      recordId: recordId,
      recipientId: recipientId,
    );
  }
}
