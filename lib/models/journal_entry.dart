class JournalEntry {
  final String title;
  final String content;
  final DateTime timestamp;

  JournalEntry({
    required this.title,
    required this.content,
    required this.timestamp,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) => JournalEntry(
        title: json['title'] ?? '',
        content: json['content'] ?? '',
        timestamp: DateTime.parse(json['timestamp']),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'timestamp': timestamp.toIso8601String(),
      };
}
