const String tableNotes = 'pbl';

class ModelField {
  static final List<String> values = ["id", "gambar"];

  static const String id = '_id';
  static const String gambar = 'gambar';
}

class Model {
  final int? id;
  final String gambar;

  const Model({this.id, required this.gambar});

  Model copy({int? id, String? gambar}) =>
      Model(id: id ?? this.id, gambar: gambar ?? this.gambar);
}
