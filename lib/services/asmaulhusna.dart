import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/asmaulhusna.dart';

class DataServiceAsmaul {
  Future<List<AsmaulHusna>> fetchAsmaulHusna() async {
    final String response = await rootBundle.loadString('assets/data/asmaul_husna.json');
    final List<dynamic> data = json.decode(response);
    
    return data.map((json) => AsmaulHusna.fromJson(json)).toList();
  }
}
