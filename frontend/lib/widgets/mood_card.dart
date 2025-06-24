import 'package:flutter/material.dart';
import '../models/mood_entry.dart';

class MoodCard extends StatelessWidget {
  final MoodEntry mood;

  const MoodCard({super.key, required this.mood});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        leading: const Icon(Icons.emoji_emotions, color: Colors.teal),
        title: Text(mood.mood),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (mood.note != null && mood.note!.isNotEmpty)
              Text("Note: ${mood.note}"),
            Text(
              mood.timestamp.toLocal().toString().split('.')[0],
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
