import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/journal_entry.dart';
import '../../providers/journal_provider.dart';
import 'journal_entry_screen.dart';

class JournalListScreen extends StatelessWidget {
  const JournalListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final journalProvider = Provider.of<JournalProvider>(context);
    final journalEntries = journalProvider.entries;

    return Scaffold(
      appBar: AppBar(title: const Text('My Journal')),
      body: RefreshIndicator(
        onRefresh: () => journalProvider.fetchJournalEntries(),
        child: journalEntries.isEmpty
            ? const Center(child: Text("No entries yet."))
            : ListView.builder(
                itemCount: journalEntries.length,
                itemBuilder: (context, index) {
                  final JournalEntry entry = journalEntries[index];
                  return ListTile(
                    title: Text(entry.title),
                    subtitle: Text(
                      entry.timestamp.toLocal().toString().split(' ')[0],
                      style: const TextStyle(color: Colors.grey),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(entry.title),
                          content: Text(entry.content),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => JournalEntryScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
