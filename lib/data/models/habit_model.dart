class HabitModel {
  final String id;
  final DateTime createdAt;
  final String title;
  final String description;
  final int stars;
  final String goal;
  final bool isPublic;
  final int totalMembers;
  final int totalRecords;
  final String frequencyId;
  final String categoryId;
  final String creatorId;

  HabitModel({required this.id, required this.createdAt, required this.title, required this.description, required this.stars, required this.goal, required this.isPublic, required this.totalMembers, required this.totalRecords, required this.frequencyId, required this.categoryId, required this.creatorId});

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
      'title': title,
      'description': description,
      'stars': starts,
      'goal': goal,
      'is_public': isPublic,
      'total_members': totalMembers,
      'total_records': totalRecords,
      'creator_id': creatorId,
    };
  }

  static HabitModel fromMap(Map<String, dynamic> data) {
    return HabitModel(
      id: data['id'] as String,
      createdAt: data['created_at'] as DateTime,
      title: data['title'] as String,
      description: data['description'] as String,
      stars: data['stars'] as int,
      goal: data['goal'] as String,
      isPublic: data['is_public'] as bool,
      totalMembers: data['total_members'] as int,
      totalRecords: data['total_records'] as int,
      creatorId: data['creator_id'] as String,
    );
  }
  
}
