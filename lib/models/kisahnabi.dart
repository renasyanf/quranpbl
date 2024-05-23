class KisahNabi {
  final String name;
  final String description;
  
  

  KisahNabi({
    required this.name,
    required this.description,
   
  });

  factory KisahNabi.fromJson(Map<String, dynamic> json) {
    return KisahNabi(
      name: json['name'] as String,
     description: json['description'] as String, 
    );
  }
}
