import 'package:flutter/material.dart';
import 'package:quranpbl/component/header.dart';
import '../services/dzikirpagi.dart';
import '../models/dzikirpagi.dart';

class DzikiPagiScreen extends StatelessWidget {
  final String doaNumber;
  final DataServiceDzikirPagi doaService = DataServiceDzikirPagi();

  DzikiPagiScreen({required this.doaNumber}); // Corrected the constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Dzikir Pagi', imagePath: 'assets/icon/quran.png'),
      body: FutureBuilder<List<DzikirPagi>>(
        future: doaService.fetchDzikir(), // Using the correct future method
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            return ListView.separated(
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
                      SizedBox(height: 5), // Add space between translation and notes
                      Text(dzikir.notes, style: TextStyle(fontSize: 16)),
                      SizedBox(height: 5), // Add space between notes and source
                      Text(dzikir.source, style: TextStyle(fontSize: 16)),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey, // Color of the separator line
                  thickness: 1, // Thickness of the separator line
                  indent: 16, // Indentation for the separator line
                  endIndent: 16, // End indentation for the separator line
                );
              },
            );
          }
        },
      ),
    );
  }
}
