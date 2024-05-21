import 'package:flutter/material.dart';
import 'package:quranpbl/component/header.dart';
import '../services/doa.dart';
import '../models/doa.dart';

class DoaListScreen extends StatelessWidget {
  final String doaNumber;
  final DoaService doaService = DoaService();

  DoaListScreen({required this.doaNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Detail Doa', imagePath: 'assets/icon/quran.png'),
      body: FutureBuilder<List<Doa>>(
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
                final doa = snapshot.data![index];
                return ListTile(
                  title: Text(doa.judul),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doa.arab, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text(doa.indo, style: TextStyle(fontSize: 16)),
                    ],
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
