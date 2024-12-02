class ChatModel {
  final String id;
  final DateTime createdAt;
  final String habitId;

  ChatModel({required this.id, required this.createdAt, required this.habitId});

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'habitId': habitId,
    };
  }

  static ChatModel fromMap(Map<String, dynamic> data) {
    return ChatModel(
      id: data['id'] as String,
      createdAt: data['createdAt'] as DateTime,
      habitId: data['habitId'] as String,
    );
  }
}
