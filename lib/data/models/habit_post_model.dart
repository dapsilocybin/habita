
class HabitPost {
  final String id;
  final String username;
  final String userFullName;
  final String habitName;
  final String frequency;
  final int habitRecordCount;
  final String time;
  final String caption;
  final String? image;
  final int likes;
  final int comments;
  final DateTime createdAt;

  const HabitPost({
    required this.id,
    required this.username,
    required this.userFullName,
    required this.habitName,
    required this.frequency,
    required this.habitRecordCount,
    required this.time,
    required this.caption,
    this.image,
    required this.likes,
    required this.comments,
    required this.createdAt,
  });

  HabitPost copyWith({int? likes}) {
    return HabitPost(
      id: id,
      username: username,
      userFullName: userFullName,
      habitName: habitName,
      frequency: frequency,
      habitRecordCount: habitRecordCount,
      time: time,
      caption: caption,
      image: image,
      likes: likes ?? this.likes,
      comments: comments,
      createdAt: createdAt,
    );
  }
}
