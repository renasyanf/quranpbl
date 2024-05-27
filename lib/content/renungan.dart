import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:quranpbl/component/header.dart';
import 'package:sqflite/sqflite.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../DbHelper.dart';

class Renungan extends StatefulWidget {
  @override
  _RenunganState createState() => _RenunganState();
}

class _RenunganState extends State<Renungan> {
  Future<List<String>> getImages() async {
    await DbHelper.copyDatabase('pbl.db');
    Database database = await openDatabase('pbl.db');

    List<Map> result = await database
        .rawQuery('SELECT path_gambar FROM gambar WHERE id BETWEEN 31 AND 48');

    List<String> imageList =
        result.map((e) => e['path_gambar'] as String).toList();

    await database.close();
    return imageList;
  }

  Future<void> saveImage(String assetPath) async {
    try {
      final byteData = await rootBundle.load('assets/renungan/$assetPath');
      final Uint8List bytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/$assetPath').create();
      await file.writeAsBytes(bytes);

      final result = await ImageGallerySaver.saveFile(file.path);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gambar disimpan: $result')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan gambar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Renungan', imagePath: 'assets/icon/renungan.png'),
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
                  crossAxisCount: 1,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemBuilder: (context, index) {
                  final imagePath = imageList[index];
                  return Stack(
                    children: [
                      Image.asset('assets/renungan/$imagePath'),
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: FloatingActionButton(
                          mini: true,
                          onPressed: () => saveImage(imagePath),
                          backgroundColor: Color(0xFF006769), 
                          foregroundColor: Color.fromARGB(255, 255, 245, 237),
                          child: Icon(Icons.save_alt),
                        ),
                      ),
                    ],
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
