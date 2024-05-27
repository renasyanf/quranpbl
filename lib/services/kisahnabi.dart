import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/kisahnabi.dart';

class KisahNabiService {
  Future<List<KisahNabi>> fetchAyatList(String doaNumber) async {
    final String response = await rootBundle.loadString('assets/data/kisahnabi.json');
    final List<dynamic> data = json.decode(response);
    
    List<KisahNabi> listDoa = [];
    for (var doaData in data) {
      if (doaData['name'] == doaNumber) {
        listDoa.add(KisahNabi.fromJson(doaData));
      }
    }
    return listDoa;
  }
}
