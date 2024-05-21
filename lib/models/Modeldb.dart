const String tableNotes = 'pbl';

class ModelField {
  static final List<String> values = ["id", "hijaiyah", "gambar"];

  static const String id = 'id';
  static const String hijaiyah = 'hijaiyah';
  static const String gambar = 'gambar';
}

class Model {
  final int? id;
  final String hijaiyah;
  final String gambar;

  const Model({this.id, required this.hijaiyah, required this.gambar});

  Model copy({int? id, String?hijaiyah, String? gambar}) =>
      Model(id: id ?? this.id, hijaiyah: hijaiyah?? this.hijaiyah ,gambar: gambar ?? this.gambar);
}
