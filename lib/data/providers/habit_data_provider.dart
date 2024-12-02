import 'package:supabase_flutter/supabase_flutter.dart';

class HabitDataProvider {
  final SupabaseClient _client;

  HabitDataProvider(this._client);

  Future<void> createHabit(Map<String, dynamic> habitData) async {
    final response = await _client.from('habits').insert(habitData);
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
  }

  Future<List<Map<String, dynamic>>> fetchHabits() async {
    return [];
    // final response = await _client.from('habits').select().call();
    // if (response.error != null) {
    //   throw Exception(response.error!.message);
    // }
    // return List<Map<String, dynamic>>.from(response.data ?? []);
  }
}
