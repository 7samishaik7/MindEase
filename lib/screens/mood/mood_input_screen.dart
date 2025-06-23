import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/mood_entry.dart';
import '../../providers/mood_provider.dart';
import '../../core/utils.dart';

class MoodInputScreen extends ConsumerWidget {
  MoodInputScreen({super.key});

  final _noteCtrl = TextEditingController();
  final List<String> moods = ['Happy', 'Sad', 'Anxious', 'Calm', 'Excited'];
  final ValueNotifier<String?> selectedMood = ValueNotifier(null);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moodNotifier = ref.read(moodListProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("How are you feeling?")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              spacing: 10,
              children: moods
                  .map(
                    (mood) => ValueListenableBuilder<String?>(
                      valueListenable: selectedMood,
                      builder: (_, value, __) => ChoiceChip(
                        label: Text(mood),
                        selected: value == mood,
                        onSelected: (_) => selectedMood.value = mood,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _noteCtrl,
              decoration: const InputDecoration(
                labelText: 'Optional note',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (selectedMood.value == null) {
                  showSnack(context, "Please select a mood", isError: true);
                  return;
                }

                final entry = MoodEntry(
                  mood: selectedMood.value!,
                  note: _noteCtrl.text,
                  timestamp: DateTime.now(),
                );

                await moodNotifier.addMood(entry);
                if (context.mounted) {
                  showSnack(context, "Mood saved!");
                  _noteCtrl.clear();
                  selectedMood.value = null;
                }
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
