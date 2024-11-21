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
}
