import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/journal_entry.dart';
import '../services/journal_service.dart';

final journalServiceProvider = Provider<JournalService>((ref) => JournalService());

final journalListProvider = StateNotifierProvider<JournalListNotifier, List<JournalEntry>>(
  (ref) => JournalListNotifier(ref.read(journalServiceProvider)),
);

class JournalListNotifier extends StateNotifier<List<JournalEntry>> {
  final JournalService _service;

  JournalListNotifier(this._service) : super([]);

  Future<void> fetchJournalEntries() async {
    final entries = await _service.getJournalHistory();
    state = entries;
  }

  Future<void> addJournalEntry(JournalEntry entry) async {
    final success = await _service.addEntry(entry);
    if (success) {
      state = [...state, entry];
    }
  }
}
