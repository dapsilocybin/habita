class HabitModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String creatorId;
  final bool isPublic;
  final int numberOfmembers;
  final int numberOfRecords;
  final int stars;
  final List<String> tags;
  final List<int> memberIds;
  final String goal;
  final String frequency;
  final DateTime startDate;

  HabitModel({required this.id, required this.title, required this.description, required this.category, required this.creatorId, required this.isPublic, required this.numberOfmembers, required this.numberOfRecords, required this.stars, required this.tags, required this.memberIds, required this.goal, required this.frequency, required this.startDate});
}
