import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/mood_entry.dart';
import '../../providers/mood_provider.dart';

class MoodHistoryScreen extends ConsumerWidget {
  const MoodHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moodList = ref.watch(moodListProvider);
    final moodNotifier = ref.read(moodListProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Mood History")),
      body: RefreshIndicator(
        onRefresh: () => moodNotifier.fetchMoods(),
        child:
            moodList.isEmpty
                ? const Center(child: Text("No mood entries yet."))
                : ListView.builder(
                  itemCount: moodList.length,
                  itemBuilder: (context, index) {
                    final MoodEntry mood = moodList[index];
                    return ListTile(
                      title: Text(mood.mood),
                      subtitle: Text(
                        '${mood.timestamp.toLocal().toString().split("T").first}${mood.note != null ? '\nNote: ${mood.note}' : ''}',
                      ),
                      isThreeLine: mood.note != null,
                    );
                  },
                ),
      ),
    );
  }
}
