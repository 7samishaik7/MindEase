import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core/constants.dart';
import '../models/journal_entry.dart';


class JournalService {
  final String token;

  JournalService({required this.token});

  // Add a new journal entry
  Future<bool> addEntry(String title, String content) async {
    final response = await http.post(
      Uri.parse('$baseUrl/journal/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'title': title,
        'content': content,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      throw Exception(jsonDecode(response.body)['detail'] ?? "Failed to add entry");
    }
  }

  // Fetch all journal entries for current user
  Future<List<JournalEntry>> getJournalEntries() async {
    final response = await http.get(
      Uri.parse('$baseUrl/journal/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((e) => JournalEntry.fromJson(e)).toList();
    } else {
      throw Exception(jsonDecode(response.body)['detail'] ?? "Failed to fetch journal entries");
    }
  }
}
