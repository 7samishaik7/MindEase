import '../models/mood_entry.dart';

List<MoodEntry> demoMoodEntries = List.generate(
  7,
  (i) => MoodEntry(date: DateTime.now().subtract(Duration(days: i)), mood: i % 5),
);
