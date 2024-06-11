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
                          MaterialPageRoute(builder: (context) => Tajwid()),
                        );
              }),
              SizedBox(height: 25),
              MenuButton(label: 'Hukum Mim Sukun', onTap: (){}),
              SizedBox(height: 25),
              MenuButton(label: 'Gunnah', onTap: (){}),
              SizedBox(height: 25),
              MenuButton(label: 'Macam-macam Idghom', onTap: (){}),
              SizedBox(height: 25),
              MenuButton(label: 'Hukum Lam Ta\'rif', onTap: (){}),
              SizedBox(height: 25),
              MenuButton(label: 'Qolqolah', onTap: (){}),
              SizedBox(height: 25),
              MenuButton(label: 'Hukum Bacaan Mad', onTap: (){}),
            ]
          ),
        ),
      ),
    );
  }
}
