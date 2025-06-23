import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/mood_entry.dart';
import '../services/mood_service.dart';

final moodServiceProvider = Provider<MoodService>((ref) => MoodService());

final moodListProvider = StateNotifierProvider<MoodListNotifier, List<MoodEntry>>(
  (ref) => MoodListNotifier(ref.read(moodServiceProvider)),
);

class MoodListNotifier extends StateNotifier<List<MoodEntry>> {
  final MoodService _service;

  MoodListNotifier(this._service) : super([]);

  Future<void> fetchMoods() async {
    final moods = await _service.getMoodHistory();
    state = moods;
  }

  Future<void> addMood(MoodEntry mood) async {
    final success = await _service.addMood(mood);
    if (success) {
      state = [...state, mood];
    }
  }
}
