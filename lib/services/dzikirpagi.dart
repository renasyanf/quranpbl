import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/dzikirpagi.dart';

class DataServiceDzikirPagi {
  Future<List<DzikirPagi>> fetchDzikir() async {
    final String response = await rootBundle.loadString('assets/data/dzikirpagi.json');
    final List<dynamic> data = json.decode(response);

    return data.map((json) => DzikirPagi.fromJson(json)).toList();
  }
}
