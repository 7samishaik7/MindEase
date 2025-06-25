import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import '../services/mood_service.dart';

class MoodProvider with ChangeNotifier {
  final MoodService _service = MoodService();
  List<MoodEntry> _moods = [];

  List<MoodEntry> get moods => _moods;

  Future<void> fetchMoods() async {
    _moods = await _service.getMoodHistory();
    notifyListeners();
  }

  Future<void> addMood(MoodEntry mood) async {
    final success = await _service.addMood(mood);
    if (success) {
      _moods.add(mood);
      notifyListeners();
    }
  }
}
