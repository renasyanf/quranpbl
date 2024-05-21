class Surat {
  final String name;
  final String revelation;
  final int numberOfVerses;
  final String number; 
  final String name_short; 

  Surat({
    required this.name,
    required this.revelation,
    required this.numberOfVerses,
    required this.number,
    required this.name_short,
  });

  factory Surat.fromJson(Map<String, dynamic> json) {
    return Surat(
      name: json['name_id'] as String,
      revelation: json['revelation_id'] as String,
      numberOfVerses: int.parse(json['number_of_verses']),
      number: json['number'] as String, 
      name_short: json['name_short'] as String,
    );
  }
}
