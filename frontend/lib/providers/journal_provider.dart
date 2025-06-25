import 'package:flutter/material.dart';
import '../models/journal_entry.dart';
import '../services/journal_service.dart';

class JournalProvider with ChangeNotifier {
  late final JournalService _service;
  bool _initialized = false;

  List<JournalEntry> _entries = [];
  List<JournalEntry> get entries => _entries;

  /// Initialize with JWT token only once
  void initialize(String token) {
    if (!_initialized) {
      _service = JournalService(token: token);
      _initialized = true;
    }
  }

  /// Fetch all journal entries
  Future<void> fetchJournalEntries() async {
    try {
      _entries = await _service.getJournalEntries();
      notifyListeners();
    } catch (e) {
      debugPrint("❌ Failed to fetch journal entries: $e");
      rethrow;
    }
  }

  /// Add a new journal entry
  Future<void> addJournalEntry(JournalEntry entry) async {
    try {
      final success = await _service.addEntry(entry.title, entry.content);
      if (success) {
        _entries = [..._entries, entry];
        notifyListeners();
      }
    } catch (e) {
      debugPrint("❌ Failed to add journal entry: $e");
      rethrow;
    }
  }
}
