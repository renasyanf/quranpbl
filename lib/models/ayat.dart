// models/ayat.dart
class Ayat {
  final String arab;
  final String latin;
  final String text;
  final String ayah;

  Ayat({
    required this.arab,
    required this.latin,
    required this.text,
    required this.ayah,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      arab: json['arab'] ?? '',
      latin: json['latin'] ?? '',
      text: json['text'] ?? '',
      ayah: json['ayah'] ?? '',
    );
  }
}
