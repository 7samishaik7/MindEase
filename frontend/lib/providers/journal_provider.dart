import 'package:flutter/material.dart';
import '../models/journal_entry.dart';
import '../services/journal_service.dart';

class JournalProvider with ChangeNotifier {
  final JournalService _service = JournalService();

  List<JournalEntry> _entries = [];

  List<JournalEntry> get entries => _entries;

  Future<void> fetchJournalEntries() async {
    _entries = await _service.getJournalHistory();
    notifyListeners();
  }

  Future<void> addJournalEntry(JournalEntry entry) async {
    final success = await _service.addEntry(entry);
    if (success) {
      _entries = [..._entries, entry];
      notifyListeners();
    }
  }
}
