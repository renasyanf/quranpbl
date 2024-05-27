import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/dzikirpetang.dart';

class DataServiceDzikirPetang {
  Future<List<DzikirPetang>> fetchDzikir() async {
    final String response = await rootBundle.loadString('assets/data/dzikirpetang.json');
    final List<dynamic> data = json.decode(response);

    return data.map((json) => DzikirPetang.fromJson(json)).toList(); // Corrected to use DzikirPagi
  }
}
