// models/ayat.dart
class Ayat {
  final String arab;
  final String latin;
  final String text;

  Ayat({
    required this.arab,
    required this.latin,
    required this.text,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      arab: json['arab'] ?? '',
      latin: json['latin'] ?? '',
      text: json['text'] ?? '',
    );
  }
}
