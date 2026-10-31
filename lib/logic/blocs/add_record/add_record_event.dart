import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class AddRecordEvent extends Equatable {
  const AddRecordEvent();

  @override
  List<Object?> get props => [];
}

class AddRecordHabitsRequested extends AddRecordEvent {
  const AddRecordHabitsRequested();
}

class AddRecordHabitSelected extends AddRecordEvent {
  final String habitId;
  final String habitName;

  const AddRecordHabitSelected({
    required this.habitId,
    required this.habitName,
  });

  @override
  List<Object?> get props => [habitId, habitName];
}

class AddRecordCaptionChanged extends AddRecordEvent {
  final String caption;

  const AddRecordCaptionChanged(this.caption);

  @override
  List<Object?> get props => [caption];
}

class AddRecordImageSelected extends AddRecordEvent {
  final Uint8List imageBytes;
  final String imageName;

  const AddRecordImageSelected({
    required this.imageBytes,
    required this.imageName,
  });

  @override
  List<Object?> get props => [imageBytes, imageName];
}

class AddRecordImageRemoved extends AddRecordEvent {
  const AddRecordImageRemoved();
}

class AddRecordSubmitted extends AddRecordEvent {
  const AddRecordSubmitted();
}
