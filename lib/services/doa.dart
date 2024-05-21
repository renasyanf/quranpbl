import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/doa.dart';

class DoaService {
  Future<List<Doa>> fetchAyatList(String doaNumber) async {
    final String response = await rootBundle.loadString('assets/data/doa.json');
    final List<dynamic> data = json.decode(response);
    
    List<Doa> listDoa = [];
    for (var doaData in data) {
      if (doaData['judul'] == doaNumber) {
        listDoa.add(Doa.fromJson(doaData));
      }
    }
    return listDoa;
  }
}
