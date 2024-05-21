import 'package:flutter/material.dart';
import 'package:quranpbl/component/header.dart';
import '../services/listdoa.dart';
import '../models/listdoa.dart';
import '../quran/doa.dart';

class ListDoaWidget extends StatelessWidget {
  final DataServiceDoa dataService = DataServiceDoa();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Doa Sehari - hari', imagePath: 'assets/icon/quran.png'),
      body: FutureBuilder<List<ListDoa>>(
        future: dataService.fetchSuratList(), // Menggunakan future dari dataService
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
                  onTap: () {
                    // Navigasi ke halaman doa dengan membawa data doa yang dipilih
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoaListScreen(doaNumber: doa.judul),
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
