// services/ayat.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/ayat.dart';

class AyatService {
  Future<List<Ayat>> fetchAyatList(String suratNumber) async {
    final String response = await rootBundle.loadString('assets/data/ayat.json');
    final List<dynamic> data = json.decode(response);
    
    List<Ayat> ayatList = [];
    for (var ayatData in data) {
      if (ayatData['surah'] == suratNumber) {
        ayatList.add(Ayat.fromJson(ayatData));
      }
    }
    return ayatList;
  }
}
