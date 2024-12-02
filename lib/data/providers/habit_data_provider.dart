class HabitDataProvider {
  final SupabaseClient _client;

  HabitDataProvider(this._client);

  Future<void> createHabit(Map<String, dynamic> habitData) async {
    final response = await _client.from('habits').insert(habitData).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<List<Map<String, dynamic>>> fetchHabits() async {
    final response = await _client.from('habits').select().execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return List<Map<String, dynamic>>.from(response.data ?? []);
  }
}
