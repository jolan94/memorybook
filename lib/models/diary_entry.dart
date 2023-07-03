class DiaryEntry {
  final int id;
  final String title;
  final DateTime datetime;
  final String description;

  DiaryEntry({
    required this.id,
    required this.title,
    required this.datetime,
    required this.description,
  });

  factory DiaryEntry.fromJson(Map<String, dynamic> json) {
    return DiaryEntry(
      id: json['id'],
      title: json['title'],
      datetime: DateTime.parse(json['datetime']),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'datetime': datetime.toIso8601String(),
      'description': description,
    };
  }
}
