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
        future: doaService.fetchDzikir(),
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
                  final dzikir = snapshot.data![index];
                  return Container(
                    padding: EdgeInsets.all(18),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 245, 237),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Color(0xFF006769), width: 1),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      title: Text(dzikir.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dzikir.arabic, style: TextStyle(fontSize: 18, color: Colors.black)),
                          SizedBox(height: 2),
                          Text(dzikir.translation, style: TextStyle(fontSize: 16)),
                          SizedBox(height: 2),
                          Text(
                            dzikir.notes,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                            textAlign: TextAlign.justify,
                          ),
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
