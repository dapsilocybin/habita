class RecordModel {
  final String id;
  final DateTime createdAt;
  final String caption;
  final String picture;
  final String location;
  final int likes;
  final String habitId;
  final String userId;

  RecordModel({required this.id, required this.createdAt, required this.caption, required this.picture, required this.location, required this.likes, required this.habitId, required this.userId});
}
