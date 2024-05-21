import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quranpbl/component/header.dart';
import '../models/surat.dart';
import '../models/ayat.dart'; 
import '../services/ayat.dart';

class OctagonNumber extends StatelessWidget {
  final String number;
  final double size;
  final Color color;
  final TextStyle textStyle;

  OctagonNumber({
    required this.number,
    this.size = 24.0,
    this.color = Colors.blue,
    this.textStyle = const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _OctagonPainter(number: number, color: color, textStyle: textStyle),
    );
  }
}

class _OctagonPainter extends CustomPainter {
  final String number;
  final Color color;
  final TextStyle textStyle;

  _OctagonPainter({
    required this.number,
    required this.color,
    required this.textStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double side = size.width / 2;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = side / cos(pi / 8);

    // Gambar segi delapan
    Path octagonPath = Path();
    octagonPath.moveTo(centerX + side, centerY);
    for (int i = 1; i < 8; i++) {
      double angle = i * pi / 4;
      octagonPath.lineTo(centerX + radius * cos(angle), centerY + radius * sin(angle));
    }
    octagonPath.close();
    canvas.drawPath(octagonPath, Paint()..color = color);

    // Gambar nomor di dalam segi delapan
    TextPainter textPainter = TextPainter(
      text: TextSpan(text: number, style: textStyle),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(centerX - textPainter.width / 2, centerY - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SuratPage extends StatelessWidget {
  final Surat surat;

  SuratPage({required this.surat});

  String convertToPentagonArabicNumber(String number) {
    List<String> pentagonArabicNumbers = ['\u0660', '\u0661', '\u0662', '\u0663', '\u0664', '\u0665', '\u0666', '\u0667', '\u0668', '\u0669'];
    String pentagonArabicNumber = '';
    List<int> digits = number.codeUnits.map((e) => e - 48).toList();
    for (int digit in digits) {
      pentagonArabicNumber += pentagonArabicNumbers[digit];
    }
    return pentagonArabicNumber;
  }

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
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 8.0), 
                    itemCount: ayatList.length,
                    separatorBuilder: (context, index) => Divider(color: Colors.grey, indent: 16, endIndent: 16), 
                    itemBuilder: (context, index) {
                      final ayat = ayatList[index];
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, 
                          children: [
                            Row(
                              children: [
                                OctagonNumber( // Widget segi delapan untuk nomor ayat
                                  number: convertToPentagonArabicNumber(ayat.ayah),
                                  size: 24.0,
                                  color: Color(0xFF006769), // Warna segi delapan sesuai keinginan Anda
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    ayat.arab,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(fontFamily: 'amiri', fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4), 
                            Text(
                              '${ayat.text}',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontFamily: 'amiri'),
                            ),
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
