import 'package:flutter/material.dart';
import 'package:quranpbl/component/header.dart';
import '../services/listnabi.dart';
import '../models/listnabi.dart';
import '../content/kisahnabi.dart';

class ListnabiWidget extends StatelessWidget {
  final DataServiceListNabi dataService = DataServiceListNabi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(
        title: 'Nama Nabi',
        imagePath: 'assets/icon/quran.png',
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NabiSearchDelegate(dataService),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<ListNabi>>(
        future: dataService.fetchSuratList(),
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
                final nabi = snapshot.data![index];
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          "${index + 1}", // Menambahkan nomor (index + 1 karena index dimulai dari 0)
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Color(0xFF006769), // Warna latar belakang untuk nomor
                      ),
                      title: Text(
                        nabi.name,
                        style: TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 18, // Sesuaikan ukuran teks sesuai kebutuhan
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KisahNabiScreen(doaNumber: nabi.name),
                          ),
                        );
                      },
                    ),
                    Divider(
                      indent: 16,
                      endIndent: 16,
                    ),
                  ],
                );

              },
            );
          }
        },
      ),
    );
  }
}

class NabiSearchDelegate extends SearchDelegate {
  final DataServiceListNabi dataService;

  NabiSearchDelegate(this.dataService);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
           close(context, null);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    return FutureBuilder<List<ListNabi>>(
      future: dataService.fetchSuratList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data found'));
        } else {
          final results = snapshot.data!
              .where((nabi) => nabi.name.toLowerCase().contains(query.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            return Center(child: Text('No results found'));
          }

          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final nabi = results[index];
              return ListTile(
                title: Text(nabi.name),
               
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KisahNabiScreen(doaNumber: nabi.name),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
