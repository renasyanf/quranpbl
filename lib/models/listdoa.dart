class ListDoa {
  final String judul;

  ListDoa({
    required this.judul,
  });

  factory ListDoa.fromJson(Map<String, dynamic> json) {
    return ListDoa(
      judul: json['judul'] ?? '',
    );
  }
}
