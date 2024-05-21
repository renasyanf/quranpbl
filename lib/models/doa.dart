class Doa {
  final String judul;
  final String arab;
  final String indo;
  

  Doa({
    required this.judul,
    required this.arab,
    required this.indo,
  });

  factory Doa.fromJson(Map<String, dynamic> json) {
    return Doa(
      judul: json['judul'] as String,
      arab: json['arab'] as String, 
      indo: json['indo'] as String, 
    );
  }
}
