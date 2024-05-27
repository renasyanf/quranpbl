import 'package:flutter/material.dart';
import 'package:quranpbl/component/header.dart';
import '../services/dzikirpetang.dart';
import '../models/dzikirpetang.dart';

class DzikiPetangScreen extends StatelessWidget {
  final String doaNumber;
  final DataServiceDzikirPetang doaService = DataServiceDzikirPetang();

  DzikiPetangScreen({required this.doaNumber}); // Corrected the constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Dzikir Pagi', imagePath: 'assets/icon/quran.png'),
      body: FutureBuilder<List<DzikirPetang>>(
        future: doaService.fetchDzikir(), // Using the correct future method
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
                final dzikir = snapshot.data![index];
                return ListTile(
                  title: Text(dzikir.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dzikir.arabic, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text(dzikir.translation, style: TextStyle(fontSize: 16)),
                      Text(dzikir.notes, style: TextStyle(fontSize: 16)),
                      Text(dzikir.source, style: TextStyle(fontSize: 16)),
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
