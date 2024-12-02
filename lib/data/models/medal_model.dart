class MedalModel {
  final String id;
  final DateTime createdAt;
  final String title;
  final String description;
  final String habitId;

  MedalModel({required this.id, required this.createdAt, required this.title, required this.description, required this.habitId});

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'title': title,
      'description': description,
      'habitId': habitId,
    };
  }

  static MedalModel fromMap(Map<String, dynamic> data) {
    return MedalModel(
      id: data['id'] as String,
      createdAt: data['createdAt'] as DateTime,
      title: data['title'] as String,
      description: data['description'] as String,
      habitId: data['habitId'] as String,
    );
  }
  
}
