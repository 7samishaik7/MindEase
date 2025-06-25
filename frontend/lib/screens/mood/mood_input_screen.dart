import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/mood_entry.dart';
import '../../providers/mood_provider.dart';
import '../../core/utils.dart';

class MoodInputScreen extends StatefulWidget {
  const MoodInputScreen({super.key});

  @override
  State<MoodInputScreen> createState() => _MoodInputScreenState();
}

class _MoodInputScreenState extends State<MoodInputScreen> {
  final TextEditingController _noteCtrl = TextEditingController();
  final List<String> moods = ['Happy', 'Sad', 'Anxious', 'Calm', 'Excited'];
  String? selectedMood;

  @override
  Widget build(BuildContext context) {
    final moodProvider = Provider.of<MoodProvider>(context, listen: false);

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
                    (mood) => ChoiceChip(
                      label: Text(mood),
                      selected: selectedMood == mood,
                      onSelected: (_) => setState(() {
                        selectedMood = mood;
                      }),
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
                if (selectedMood == null) {
                  showSnack(context, "Please select a mood", isError: true);
                  return;
                }

                final entry = MoodEntry(
                  mood: selectedMood!,
                  note: _noteCtrl.text,
                  timestamp: DateTime.now(),
                );

                await moodProvider.addMood(entry);
                if (context.mounted) {
                  showSnack(context, "Mood saved!");
                  _noteCtrl.clear();
                  setState(() {
                    selectedMood = null;
                  });
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
