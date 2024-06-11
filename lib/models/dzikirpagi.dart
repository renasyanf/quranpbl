class DzikirPagi {
  final String title;
  final String arabic;
  final String translation;
  final String notes;


  DzikirPagi({
    required this.title,
    required this.arabic,
    required this.translation,
    required this.notes,
  });

  factory DzikirPagi.fromJson(Map<String, dynamic> json) {
    return DzikirPagi(
      title: json['title'] as String,
      arabic: json['arabic'] as String,
      translation: json['translation'] as String,
      notes: json['notes'] as String,
    );
  }
}
