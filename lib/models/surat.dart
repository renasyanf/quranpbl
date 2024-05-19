// lib/models/surat.dart
class Surat {
  final String name;
  final String revelation;
  final int numberOfVerses;
  final String number; // Tambahkan properti number

  Surat({
    required this.name,
    required this.revelation,
    required this.numberOfVerses,
    required this.number, // Tambahkan ke konstruktor
  });

  factory Surat.fromJson(Map<String, dynamic> json) {
    return Surat(
      name: json['name_id'] as String,
      revelation: json['revelation_id'] as String,
      numberOfVerses: int.parse(json['number_of_verses']),
      number: json['number'] as String, // Tambahkan ini
    );
  }
}
