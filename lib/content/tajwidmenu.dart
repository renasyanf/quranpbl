import 'package:flutter/material.dart';
import 'package:quranpbl/component/buttons.dart';
import 'package:quranpbl/component/header.dart';
import 'package:quranpbl/content/TajwidContent.dart';

class MenuTajwid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Tajwid', imagePath: 'assets/icon/TAJWID.png'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30),
              MenuButton(label: 'Hukum Nun Sukun dan Tanwin', onTap: (){
                Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Tajwid1()),
                        );
              }),
              SizedBox(height: 25),
              MenuButton(label: 'Hukum Mim Sukun', onTap: (){
                Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Tajwid6()),
                        );
              }),
              SizedBox(height: 25),
              MenuButton(label: 'Gunnah', onTap: (){
                Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Tajwid2()),
                        );
              }),
              SizedBox(height: 25),
              MenuButton(label: 'Macam-macam Idghom', onTap: (){
                Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Tajwid3()),
                        );
              }),
              SizedBox(height: 25),
              MenuButton(label: 'Hukum Lam Ta\'rif', onTap: (){
                Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Tajwid4()),
                        );
              }),
              SizedBox(height: 25),
              MenuButton(label: 'Qolqolah', onTap: (){
                Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Tajwid5()),
                        );
              }),
              
            ]
          ),
        ),
      ),
    );
  }
}
