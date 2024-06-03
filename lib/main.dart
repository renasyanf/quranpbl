import 'package:flutter/material.dart';
import 'package:quranpbl/component/buttons.dart';
import 'package:quranpbl/content/menudzikir.dart';
import 'package:quranpbl/content/hijaiyah.dart';
import 'package:quranpbl/content/listsurat.dart';
import 'package:quranpbl/content/listdoa.dart';
import 'package:quranpbl/content/asmaulhusna.dart';
import 'package:quranpbl/content/renungan.dart';
import 'package:quranpbl/content/tajwidmenu.dart';
import 'package:quranpbl/content/zakat.dart';
import 'package:quranpbl/content/listnabi.dart';
import 'package:quranpbl/content/onboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnBoardScreen(),
    );
  }
}

class OnBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 208, 255, 196),
              Color(0xFF006769),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset(
              'assets/icon/onboard.png', // Replace with your logo asset path
              height: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Welcome !',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                primary: Color(0xFF006769),
              ),
              child: Text(
                'Start Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
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
            margin: EdgeInsets.only(top: 75.0, bottom: 75.0), 
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
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MenuDzikirScreen()),
                        );
                      },
                    ),
                    SizedBox(height: 25),
                    HomeButton(
                        imagePath: 'assets/icon/nabi.png',
                        label: 'KISAH 25 NABI',
                        onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ListnabiWidget()),
                        );
                      }
                    ),
                    SizedBox(height: 25),
                    HomeButton(
                      imagePath: 'assets/icon/renungan.png', 
                      label: 'RENUNGAN', 
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Renungan()),
                        );
                      })
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
                    }),
                    SizedBox(height: 25),
                    HomeButton(imagePath: 'assets/icon/about.png', label: 'ABOUT', onTap: (){})
                  ],
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
