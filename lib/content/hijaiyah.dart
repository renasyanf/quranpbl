import 'package:flutter/material.dart';
import 'package:quranpbl/component/header.dart';
import 'package:sqflite/sqflite.dart';
import '../DbHelper.dart';

class Hijaiyah extends StatefulWidget {
  @override
  _HijaiyahState createState() => _HijaiyahState();
}

class _HijaiyahState extends State<Hijaiyah> {
  Future<List<String>> getImages() async {
    await DbHelper.copyDatabase('pbl.db');
    Database database = await openDatabase('pbl.db');

    List<Map> result = await database.rawQuery('SELECT path_gambar FROM gambar WHERE id BETWEEN 1 AND 30');

    List<String> imageList = result.map((e) => e['path_gambar'] as String).toList();

    await database.close();
    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Huruf Hijaiyah', imagePath: 'assets/icon/hijaiyah.png'),
      body: FutureBuilder<List<String>>(
        future: getImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            final imageList = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: imageList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, 
                  crossAxisSpacing: 4.0, // Spacing between columns
                  mainAxisSpacing: 4.0, // Spacing between rows
                ),
                itemBuilder: (context, index) {
                  return Image.asset('assets/hijaiyah/${imageList[index]}'); // Pastikan path disini benar
                },
              ),
            );
          }
        },
      ),
    );
  }
}