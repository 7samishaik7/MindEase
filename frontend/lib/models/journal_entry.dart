class JournalEntry {
  final int? id;
  final int? userId;
  final String title;
  final String content;
  final DateTime timestamp;

  JournalEntry({
    this.id,
    this.userId,
    required this.title,
    required this.content,
    required this.timestamp,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) => JournalEntry(
        id: json['id'],
        userId: json['user_id'],
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
