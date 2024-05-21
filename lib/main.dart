// lib/main.dart
import 'package:flutter/material.dart';
import 'package:quranpbl/component/buttons.dart';
import 'package:quranpbl/content/hijaiyah.dart';
import 'package:quranpbl/content/listsurat.dart';
import 'package:quranpbl/content/listsurat.dart';
import 'package:quranpbl/content/listdoa.dart';
import 'package:quranpbl/content/asmaulhusna.dart';
import 'package:quranpbl/content/tajwidmenu.dart';
import 'package:quranpbl/content/zakat.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 125.0), // Added top margin
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    HomeButton(
                      imagePath: 'assets/icon/quran.png',
                      label: 'BACA QURAN',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ListSurat()),
                        );
                      },
                    ),
                    SizedBox(height: 25),
                    HomeButton(
                      imagePath: 'assets/icon/TAJWID.png',
                      label: 'TAJWID',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MenuTajwid()),
                        );
                      },
                    ),
                    SizedBox(height: 25),
                    HomeButton(
                      imagePath: 'assets/icon/dzikir.png',
                      label: 'DZIKIR PAGI PETANG',
                      onTap: () {
                        // Tambahkan navigasi untuk halaman DZIKIR PAGI PETANG di sini
                      },
                    ),
                    SizedBox(height: 25),
                    HomeButton(
                        imagePath: 'assets/icon/nabi.png',
                        label: 'KISAH 25 NABI',
                        onTap: () {}
                    ),
                    HomeButton(imagePath: 'assets/icon/renungan.png', label: 'renungan', onTap: (){})
                  ],
                ),
                SizedBox(width: 25),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    HomeButton(
                      imagePath: 'assets/icon/hijaiyah.png',
                      label: 'HURUF HIJAIYAH',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Hijaiyah()),
                        );
                      },
                    ),
                    SizedBox(height: 25),
                    HomeButton(
                      imagePath: 'assets/icon/doa.png',
                      label: 'DOA SEHARI-HARI',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListDoaWidget()),
                        );
                      },
                    ),
                    SizedBox(height: 25),
                    HomeButton(
                      imagePath: 'assets/icon/asmaulhusna.png',
                      label: 'ASMAUL HUSNA',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AsmaulHusnaListScreen()),
                        );
                      },
                    ),
                    SizedBox(height: 25),
                    HomeButton(imagePath: 'assets/icon/zakat.png', label: 'KALKULATOR ZAKAT', onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ZakatCalculatorScreen()),
                        );
                    })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement About screen navigation
            },
            icon: Image.asset('assets/icon/about.png', width: 24, height: 24),
            label: Text('About'),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF006769),
              padding: EdgeInsets.symmetric(vertical: 15.0),
            ),
          ),
        ),
      ),
    );
  }
}
