class JoinedHabit {
  final String id;
  final String habitId;
  final String name;

  const JoinedHabit({
    required this.id,
    required this.habitId,
    required this.name,
  });

  factory JoinedHabit.fromMap(Map<String, dynamic> map) {
    return JoinedHabit(
      id: map['id'] as String,
      habitId: map['habit_id'] as String,
      name: map['name'] as String,
    );
  }
}
