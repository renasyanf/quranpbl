import 'package:flutter/material.dart';
import 'package:quranpbl/component/header.dart';
import 'package:sqflite/sqflite.dart';
import '../DbHelper.dart';

class Tajwid extends StatefulWidget {
  @override
  _TajwidState createState() => _TajwidState();
}

class _TajwidState extends State<Tajwid> {
  Future<List<String>> getImages() async {
    await DbHelper.copyDatabase('pbl.db');
    Database database = await openDatabase('pbl.db');

    List<Map> result = await database.rawQuery('SELECT path_gambar FROM gambar WHERE id BETWEEN 49 AND 50');

    List<String> imageList = result.map((e) => e['path_gambar'] as String).toList();

    await database.close();
    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Nun Sukun dan Tanwin', imagePath: 'assets/icon/TAJWID.png'),
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
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Image.asset(
                        'assets/hijaiyah/${imageList[index]}',
                        fit: BoxFit.cover, // Adjust the fit to cover the container
                      ),
                    
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
