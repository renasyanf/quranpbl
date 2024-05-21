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
            return Padding(
              padding: EdgeInsets.all(18), // Add padding around the grid
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 4 items per row
                  mainAxisSpacing: 8, // Vertical spacing between items
                  crossAxisSpacing: 8, // Horizontal spacing between items
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final asmaulHusna = snapshot.data![index];
                  return Container(
                    padding: EdgeInsets.all(8), // Add padding to all sides
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey), // Border color
                      borderRadius: BorderRadius.circular(10), // Border radius
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center, // Align children to center horizontally
                      children: [
                        Text(
                          asmaulHusna.arab,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'amiri',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8), // Vertical spacing
                        Text(
                          asmaulHusna.indo,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
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
