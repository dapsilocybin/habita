class HabitRepository {
  final HabitDataProvider dataProvider;

  HabitRepository(this.dataProvider);

  Future<void> addHabit(Habit habit) async {
    final habitData = habit.toMap(); // Convert Habit model to Map
    await dataProvider.createHabit(habitData);
  }

  Future<List<Habit>> getAllHabits() async {
    final data = await dataProvider.fetchHabits();
    return data.map((habitData) => Habit.fromMap(habitData)).toList();
  }
}
