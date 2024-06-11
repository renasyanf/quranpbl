import 'package:flutter/material.dart';
import 'package:quranpbl/component/header.dart';
import '../services/dzikirpagi.dart' as pagi; // Import with unique prefix
import '../services/dzikirpetang.dart' as petang; // Import with unique prefix
import '../content/dzikirpagi.dart';
import '../content/dzikirpetang.dart';

class MenuDzikirScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color appBarColor = Color.fromARGB(255, 255, 245, 237);
    Color buttonColor =  Color(0xFF006769);// Set button color to green

    return Scaffold(
      backgroundColor: appBarColor,
      appBar: Header(title: 'Dzikir Pagi Petang', imagePath: 'assets/icon/quran.png'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DzikiPagiScreen(doaNumber: '1')),
                );
              },
              icon: Image.asset('assets/icon/dzikir.png', width: 50, height: 50), // Replace with your image path
              label: Text('Dzikir Pagi'),
              style: ElevatedButton.styleFrom(
                primary: buttonColor, // Button color set to green
                onPrimary: Colors.white, // Text and icon color
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Make button round
                ),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DzikiPetangScreen(doaNumber: '1')),
                );
              },
              icon: Image.asset('assets/icon/dzikir.png', width: 50, height: 50), // Replace with your image path
              label: Text('Dzikir Petang'),
              style: ElevatedButton.styleFrom(
                primary: buttonColor, // Button color set to green
                onPrimary: Colors.white, // Text and icon color
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Make button round
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
