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
    required String habitId,
    required String caption,
    required String frequencyLabel,
    Uint8List? imageBytes,
    String? imageName,
  }) {
    return addRecordProvider.publishRecord(
      habitId: habitId,
      caption: caption,
      frequencyLabel: frequencyLabel,
      imageBytes: imageBytes,
      imageName: imageName,
    );
  }
}
