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
              padding: EdgeInsets.all(16.0), // Added padding around the list
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final nabi = snapshot.data![index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10), // Added margin here
                    decoration: BoxDecoration( // Added decoration here
                      color: Color.fromARGB(255, 255, 245, 237),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Color(0xFF006769), width: 1),
                    ),
                    child: ListTile(
                      title: Text(
                        nabi.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Amiri',
                          fontSize: 18,
                          color: Color.fromARGB(255, 134, 109, 91),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      subtitle: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            Text(
                              nabi.description,
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
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
