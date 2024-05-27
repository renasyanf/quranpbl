import 'package:flutter/material.dart';
import 'package:quranpbl/component/header.dart';
import '../services/kisahnabi.dart';
import '../models/kisahnabi.dart';

class KisahNabiScreen extends StatelessWidget {
  final String doaNumber;
  final KisahNabiService doaService = KisahNabiService();

  KisahNabiScreen({required this.doaNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Kisah Nabi', imagePath: 'assets/icon/quran.png'),
      body: FutureBuilder<List<KisahNabi>>(
        future: doaService.fetchAyatList(doaNumber), // Menggunakan future dari doaService
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final nabi = snapshot.data![index];
                return ListTile(
                  title:  Text(
                        nabi.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Amiri',fontSize: 18, color: Color.fromARGB(255, 134, 109, 91)),
                      ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0), 
                  subtitle: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0), // Memberikan jarak di sisi kiri dan kanan
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         SizedBox(height: 15), 
                        Text(
                          nabi.description,
                          style: TextStyle(fontSize: 15,),
                          textAlign: TextAlign.justify, // Deskripsi rata kanan-kiri
                        ),
                       
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
