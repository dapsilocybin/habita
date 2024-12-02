class ChatModel {
  final String id;
  final DateTime createdAt;
  final String habitId;

  ChatModel({required this.id, required this.createdAt, required this.habitId});

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
      'habit_id': habitId,
    };
  }

  static ChatModel fromMap(Map<String, dynamic> data) {
    return ChatModel(
      id: data['id'] as String,
      createdAt: data['created_at'] as DateTime,
      habitId: data['habit_id'] as String,
    );
  }
}
