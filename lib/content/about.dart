import 'package:flutter/material.dart';
import 'package:quranpbl/component/header.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Tentang Aplikasi', imagePath: 'assets/icon/quran.png'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    Text(
                      'Aplikasi Belajar Alquran',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'HIDAYAH',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Aplikasi ini dirancang untuk membantu pengguna dalam belajar membaca, memahami, '
                'dan menghafal Alqur\'an. Fitur utama yang tersedia dalam aplikasi ini:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(text: 'Baca Alquran\n', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'Fitur Baca Alquran menyediakan daftar surah-surah pada Alquran. Fitur ini mencakup:\n'),
                    TextSpan(text: '• Pengguna dapat memilih surah yang ingin dibaca\n', style: TextStyle(fontSize: 16)),
                    TextSpan(text: '• Pengguna dapat membaca dan mengetahui arti dari setiap ayat Alquran\n', style: TextStyle(fontSize: 16)),
                    TextSpan(text: '• Pengguna dapat menggunakan fitur speech recognition untuk mencocokkan bacaan yang telah dibaca apakah sudah benar atau belum.\n', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Versi Aplikasi: 1.0.0',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Pengembang: Team Qurani Tech',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Kontak: syahlachandra@student.uns.ac.id.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: AboutPage(),
));
