const String tableNotes = 'pbl';

class ModelField {
  static final List<String> values = ["id", "gambar", "audio"]; // tambahkan audio ke values

  static const String id = 'id';
  static const String gambar = 'gambar';
  static const String audio = 'audio'; // tambahkan audio sebagai konstanta
}

class Model {
  final int? id;
  final String gambar;
  final String audio; // tambahkan properti audio

  const Model({this.id, required this.gambar, required this.audio});

  Model copy({int? id, String? gambar, String? audio}) =>
      Model(id: id ?? this.id, gambar: gambar ?? this.gambar, audio: audio ?? this.audio);
}
