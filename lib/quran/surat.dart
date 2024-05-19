import 'package:flutter/material.dart';
import 'package:quranpbl/component/header.dart';
import '../models/surat.dart';
import '../models/ayat.dart';
import '../services/ayat.dart';

class SuratPage extends StatelessWidget {
  final Surat surat;

  SuratPage({required this.surat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Baca Quran', imagePath: 'assets/icon/quran.png'),
      body: FutureBuilder<List<Ayat>>(
        future: AyatService().fetchAyatList(surat.number),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            final ayatList = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
  padding: const EdgeInsets.all(8.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        surat.name,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color.fromARGB(255, 134, 109, 91)),
      ),
      SizedBox(height: 4),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${surat.numberOfVerses} - ${surat.revelation}',
            style: TextStyle(fontSize: 14, color: Color(0xFFC7B7A3)),
          ),
        ],
      ),
    ],
  ),
),

                SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemCount: ayatList.length,
                    itemBuilder: (context, index) {
                      final ayat = ayatList[index];
                      return ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              ayat.arab,
                              textAlign: TextAlign.right,
                              style: TextStyle(fontFamily: 'arabic', fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4), // Jarak antar baris
                            Text(
                              '${ayat.text}',
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(height: 6),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
