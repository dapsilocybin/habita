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

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'caption': caption,
      'picture': picture,
      'location': location,
      'likes': likes,
      'habitId': habitId,
      'userId': userId,
    };
  }

  static RecordModel fromMap(Map<String, dynamic> data) {
    return RecordModel(
      id: data['id'] as String,
      createdAt: data['createdAt'] as DateTime,
      caption: data['caption'] as String,
      picture: data['picture'] as String,
      location: data['location'] as String,
      likes: data['likes'] as int,
      habitId: data['habitId'] as String,
      userId: data['userId'] as String,
    );
  }
}
