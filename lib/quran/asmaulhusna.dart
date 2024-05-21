import 'package:flutter/material.dart';
import 'package:quranpbl/component/header.dart';
import '../services/asmaulhusna.dart'; // Correct import path for service
import '../models/asmaulhusna.dart'; // Correct import path for model

class AsmaulHusnaListScreen extends StatelessWidget {
  final DataServiceAsmaul dataService = DataServiceAsmaul(); // Correct class name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Asmaul Husna', imagePath: 'assets/icon/quran.png'),
      body: FutureBuilder<List<AsmaulHusna>>(
        future: dataService.fetchAsmaulHusna(), // Correct method name
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
                final asmaulHusna = snapshot.data![index];
                return ListTile(
                  title: Text(asmaulHusna.arab),
                  subtitle: Text(asmaulHusna.indo),
                );
              },
            );
          }
        },
      ),
    );
  }
}
