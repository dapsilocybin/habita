import 'package:habita/data/models/habit_model.dart';

import '../providers/habit_data_provider.dart';

class HabitRepository {
  final HabitDataProvider dataProvider;

  HabitRepository(this.dataProvider);

  Future<void> addHabit(HabitModel habit) async {
    final habitData = habit.toMap(); // Convert Habit model to Map
    await dataProvider.createHabit(habitData);
  }

  Future<List<HabitModel>> getAllHabits() async {
    final data = await dataProvider.fetchHabits();
    return data.map((habitData) => HabitModel.fromMap(habitData)).toList();
  }
}
