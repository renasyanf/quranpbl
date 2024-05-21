import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/listdoa.dart';

class DataServiceDoa {
  Future<List<ListDoa>> fetchSuratList() async {
    final String response = await rootBundle.loadString('assets/data/doa.json');
    final List<dynamic> data = json.decode(response);
    
    return data.map((json) => ListDoa.fromJson(json)).toList();
  }
}
