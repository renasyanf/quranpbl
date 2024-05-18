import 'package:flutter/material.dart';
import 'package:quranpbl/buttons.dart';

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
                    ),
                    SizedBox(height: 25),
                    HomeButton(
                      imagePath: 'assets/icon/TAJWID.png',
                      label: 'TAJWID',
                    ),
                    SizedBox(height: 25),
                    HomeButton(
                      imagePath: 'assets/icon/dzikir.png',
                      label: 'DZIKIR PAGI PETANG',
                    ),
                  ],
                ),
                SizedBox(width: 25),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    HomeButton(
                      imagePath: 'assets/icon/hijaiyah.png',
                      label: 'HURUF HIJAIYAH',
                    ),
                    SizedBox(height: 25),
                    HomeButton(
                      imagePath: 'assets/icon/doa.png',
                      label: 'DOA SEHARI-HARI',
                    ),
                    SizedBox(height: 25),
                    HomeButton(
                      imagePath: 'assets/icon/asmaulhusna.png',
                      label: 'ASMAUL HUSNA',
                    )
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
