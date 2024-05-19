// lib/services/surat.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/surat.dart';

class DataServiceSurat {
  Future<List<Surat>> fetchSuratList() async {
    final String response = await rootBundle.loadString('assets/data/surah.json');
    final List<dynamic> data = json.decode(response);
    
    return data.map((json) => Surat.fromJson(json)).toList();
  }
}
