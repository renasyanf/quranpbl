import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Future<void> copyDatabase(String dbName) async {
    ByteData data = await rootBundle.load("assets/$dbName");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Mendapatkan path untuk penyimpanan database di perangkat
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, dbName);

    // Menulis data bytes ke path yang ditentukan
    await File(dbPath).writeAsBytes(bytes);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
    // Menyalin database dari aset ke penyimpanan lokal perangkat
  await DbHelper.copyDatabase('pbl.db');

  // Membuka database
  Database database = await openDatabase('pbl.db');
  // close
  await database.close();
  
}
