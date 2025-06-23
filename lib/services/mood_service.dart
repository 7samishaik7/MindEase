import 'dart:convert';
import '../models/mood_entry.dart';
import 'api_client.dart';

class MoodService {
  final ApiClient _client = ApiClient();

  Future<bool> addMood(MoodEntry mood) async {
    final res = await _client.post('/mood', mood.toJson());
    return res.statusCode == 201;
  }

  Future<List<MoodEntry>> getMoodHistory() async {
    final res = await _client.get('/mood/history');
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as List;
      return data.map((e) => MoodEntry.fromJson(e)).toList();
    }
    return [];
  }
}
