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
  final String frequency;
  final String categoryId;
  final String creatorId;
  final int numberOfmembers;
  final int numberOfRecords;

  final List<String> tags;
  final List<int> memberIds;

  final DateTime startDate;

  HabitModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.creatorId,
      required this.isPublic,
      required this.numberOfmembers,
      required this.numberOfRecords,
      required this.stars,
      required this.tags,
      required this.memberIds,
      required this.goal,
      required this.frequency,
      required this.startDate});
}
