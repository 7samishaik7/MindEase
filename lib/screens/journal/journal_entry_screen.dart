import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils.dart';
import '../../models/journal_entry.dart';
import '../../providers/journal_provider.dart';

class JournalEntryScreen extends ConsumerWidget {
  JournalEntryScreen({super.key});

  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journalNotifier = ref.read(journalListProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('New Journal Entry')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleCtrl,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contentCtrl,
              maxLines: 10,
              decoration: const InputDecoration(labelText: 'Content'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final entry = JournalEntry(
                  title: _titleCtrl.text,
                  content: _contentCtrl.text,
                  timestamp: DateTime.now(),
                );

                await journalNotifier.addJournalEntry(entry);
                if (context.mounted) {
                  showSnack(context, "Journal entry saved!");
                  Navigator.pop(context);
                }
              },
              child: const Text('Save Entry'),
            ),
          ],
        ),
      ),
    );
  }
}
