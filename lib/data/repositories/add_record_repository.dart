import 'dart:typed_data';

import 'package:habita/data/models/joined_habit_model.dart';
import 'package:habita/data/providers/add_record_provider.dart';

class AddRecordRepository {
  final AddRecordProvider addRecordProvider;

  AddRecordRepository({required this.addRecordProvider});

  Future<List<JoinedHabit>> fetchJoinedHabits() {
    return addRecordProvider.fetchJoinedHabits();
  }

  Future<void> publishRecord({
    required String userHabitId,
    required String caption,
    Uint8List? imageBytes,
    String? imageName,
  }) {
    return addRecordProvider.publishRecord(
      userHabitId: userHabitId,
      caption: caption,
      imageBytes: imageBytes,
      imageName: imageName,
    );
  }
}
