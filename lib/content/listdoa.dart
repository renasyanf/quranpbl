import 'package:flutter/material.dart';
import 'package:quranpbl/component/header.dart';
import '../services/listdoa.dart';
import '../models/listdoa.dart';
import '../content/doa.dart';

class ListDoaWidget extends StatelessWidget {
  final DataServiceDoa dataService = DataServiceDoa();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(
        title: 'Daftar Doa',
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
      body: FutureBuilder<List<ListDoa>>(
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
                final doa = snapshot.data![index];
                return ListTile(
                  title: Text(doa.judul),
                  onTap: () {
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

class NabiSearchDelegate extends SearchDelegate {
  final DataServiceDoa dataService;

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
    return FutureBuilder<List<ListDoa>>(
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
              .where((doa) => doa.judul.toLowerCase().contains(query.toLowerCase()))
              .toList();

          if (results.isEmpty) {
            return Center(child: Text('No results found'));
          }

          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final doa = results[index];
              return ListTile(
                title: Text(doa.judul),
               
                onTap: () {
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
    );
  }
}
