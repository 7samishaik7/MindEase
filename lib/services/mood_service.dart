import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/mood_entry.dart';
import 'dart:convert';

final moodServiceProvider = Provider<MoodService>((ref) => MoodService());

class MoodService {
  Future<void> addMood(int mood) async {
    final prefs = await SharedPreferences.getInstance();
    final entriesJson = prefs.getString('mood_entries') ?? '[]';
    final List decoded = jsonDecode(entriesJson);
    decoded.add({'date': DateTime.now().toIso8601String(), 'mood': mood});
    await prefs.setString('mood_entries', jsonEncode(decoded));
  }

  Future<List<MoodEntry>> getMoodHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final entriesJson = prefs.getString('mood_entries') ?? '[]';
    final List decoded = jsonDecode(entriesJson);
    return decoded
        .map((e) => MoodEntry(date: DateTime.parse(e['date']), mood: e['mood']))
        .toList();
  }
}
