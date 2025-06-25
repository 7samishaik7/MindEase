import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/mood_entry.dart';
import '../../providers/mood_provider.dart';

class MoodHistoryScreen extends StatelessWidget {
  const MoodHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moodProvider = Provider.of<MoodProvider>(context);
    final moodList = moodProvider.moods;

    return Scaffold(
      appBar: AppBar(title: const Text("Mood History")),
      body: RefreshIndicator(
        onRefresh: () => moodProvider.fetchMoods(),
        child: moodList.isEmpty
            ? const Center(child: Text("No mood entries yet."))
            : ListView.builder(
                itemCount: moodList.length,
                itemBuilder: (context, index) {
                  final MoodEntry mood = moodList[index];
                  return ListTile(
                    title: Text(mood.mood),
                    subtitle: Text(
                      '${mood.timestamp.toLocal().toString().split("T").first}${mood.note != null && mood.note!.isNotEmpty ? '\nNote: ${mood.note}' : ''}',
                    ),
                    isThreeLine: mood.note != null && mood.note!.isNotEmpty,
                  );
                },
              ),
      ),
    );
  }
}
