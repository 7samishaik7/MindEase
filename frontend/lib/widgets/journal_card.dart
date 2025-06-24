import 'package:flutter/material.dart';
import '../models/journal_entry.dart';

class JournalCard extends StatelessWidget {
  final JournalEntry entry;

  const JournalCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        leading: const Icon(Icons.book, color: Colors.teal),
        title: Text(entry.title),
        subtitle: Text(
          entry.timestamp.toLocal().toString().split(' ')[0],
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
        onTap: () => showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(entry.title),
            content: Text(entry.content),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
