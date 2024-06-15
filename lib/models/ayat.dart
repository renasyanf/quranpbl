// models/ayat.dart
class Ayat {
  final String arab;
  final String latin;
  final String text;
  final String ayah;
  final String audio;

  Ayat({
    required this.arab,
    required this.latin,
    required this.text,
    required this.ayah,
    required this.audio

  });

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      arab: json['arab'] ?? '',
      latin: json['latin'] ?? '',
      text: json['text'] ?? '',
      ayah: json['ayah'] ?? '',
      audio: json['audio'] ?? '',
    );
  }
}
