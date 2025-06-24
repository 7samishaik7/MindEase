import 'dart:convert';
import '../models/journal_entry.dart';
import 'api_client.dart';

class JournalService {
  final ApiClient _client = ApiClient();

  Future<bool> addEntry(JournalEntry entry) async {
    final res = await _client.post('/journal', entry.toJson());
    return res.statusCode == 201;
  }

  Future<List<JournalEntry>> getJournalHistory() async {
    final res = await _client.get('/journal/history');
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as List;
      return data.map((e) => JournalEntry.fromJson(e)).toList();
    }
    return [];
  }
}
