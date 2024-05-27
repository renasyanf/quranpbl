class DzikirPagi {
  final String title;
  final String arabic;
  final String translation;
  final String notes;
  final String source;

  DzikirPagi({
    required this.title,
    required this.arabic,
    required this.translation,
    required this.notes,
    required this.source,
  });

  factory DzikirPagi.fromJson(Map<String, dynamic> json) {
    return DzikirPagi(
      title: json['title'] as String,
      arabic: json['arabic'] as String,
      translation: json['translation'] as String,
      notes: json['notes'] as String,
      source: json['source'] as String, // Corrected key name
    );
  }
}
