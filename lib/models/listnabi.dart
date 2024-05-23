class ListNabi {
  final String name;

  ListNabi({
    required this.name,
  });

  factory ListNabi.fromJson(Map<String, dynamic> json) {
    return ListNabi(
      name: json['name'] ?? '',
    );
  }
}
