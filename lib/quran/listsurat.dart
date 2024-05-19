// lib/pages/list_surat.dart
import 'package:flutter/material.dart';
import 'package:quranpbl/component/header.dart';
import '../models/surat.dart';
import '../services/surat.dart';
import 'surat.dart'; // Import halaman surat baru

class ListSurat extends StatefulWidget {
  @override
  _ListSuratState createState() => _ListSuratState();
}

class _ListSuratState extends State<ListSurat> {
  late Future<List<Surat>> futureSuratList;

  @override
  void initState() {
    super.initState();
    futureSuratList = DataServiceSurat().fetchSuratList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Baca Quran', imagePath: 'assets/icon/quran.png'),
      body: FutureBuilder<List<Surat>>(
        future: futureSuratList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            final suratList = snapshot.data!;
            return ListView.builder(
              itemCount: suratList.length,
              itemBuilder: (context, index) {
                final surat = suratList[index];
                return ListTile(
                  title: Text(surat.name),
                  subtitle: Text('${surat.revelation} - ${surat.numberOfVerses} ayat'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuratPage(surat: surat),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
