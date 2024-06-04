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
        future: doaService.fetchAyatList(doaNumber),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            return Container(
              margin: EdgeInsets.all(16), // Added margin around the container
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final doa = snapshot.data![index];
                  return Container(
                    padding: EdgeInsets.all(18),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 245, 237),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Color(0xFF006769), width: 1),
                    ),
                    child: ListTile(
                      title: Text(doa.judul),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(doa.arab, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text(doa.indo, style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
