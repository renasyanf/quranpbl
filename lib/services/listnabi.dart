import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/listnabi.dart';

class DataServiceListNabi {
  Future<List<ListNabi>> fetchSuratList() async {
    final String response = await rootBundle.loadString('assets/data/kisahnabi.json');
    final List<dynamic> data = json.decode(response);
    
    return data.map((json) => ListNabi.fromJson(json)).toList();
  }
}
