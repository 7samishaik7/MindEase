class MoodEntry {
  final String mood;
  final String? note;
  final DateTime timestamp;

  MoodEntry({
    required this.mood,
    this.note,
    required this.timestamp,
  });

  factory MoodEntry.fromJson(Map<String, dynamic> json) => MoodEntry(
        mood: json['mood'] ?? '',
        note: json['note'],
        timestamp: DateTime.parse(json['timestamp']),
      );

  Map<String, dynamic> toJson() => {
        'mood': mood,
        if (note != null) 'note': note,
        'timestamp': timestamp.toIso8601String(),
      };
}
