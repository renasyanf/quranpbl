class AsmaulHusna{
  final String arab;
  final String indo;
  

  AsmaulHusna({
    required this.arab,
    required this.indo,
  });

  factory AsmaulHusna.fromJson(Map<String, dynamic> json) {
    return AsmaulHusna(
      arab: json['arab'] as String, 
      indo: json['indo'] as String, 
    );
  }
}
