import 'package:flutter/material.dart';
import '../models/surat.dart';
import '../services/surat.dart';
import 'surat.dart';
import '../component/header.dart';

class ListSurat extends StatefulWidget {
  @override
  _ListSuratState createState() => _ListSuratState();
}

class _ListSuratState extends State<ListSurat> {
  late Future<List<Surat>> futureSuratList;
  late List<String> suratNames = [];
  late List<Surat> suratList = []; // Tambahkan properti suratList

  @override
  void initState() {
    super.initState();
    futureSuratList = DataServiceSurat().fetchSuratList();
  }

  String convertToArabicNumber(String number) {
    List<String> arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    String arabicNumber = '';
    List<int> digits = number.codeUnits.map((e) => e - 48).toList();
    for (int digit in digits) {
      arabicNumber += arabicNumbers[digit];
    }
    return arabicNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(
        title: 'Baca Quran',
        imagePath: 'assets/icon/quran.png',
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SuratSearchDelegate(suratNames, suratList), // Gunakan suratList di sini
              );
            },
          ),
        ],
      ),
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
            suratList = snapshot.data!; // Inisialisasi suratList
            suratNames = suratList.map((surat) => surat.name).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Daftar Surah',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 134, 109, 91),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: suratList.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      final surat = suratList[index];
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipPath(
                                  clipper: HexagonClipper(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF006769),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    child: Text(
                                      '${convertToArabicNumber(surat.number)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  surat.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              surat.name_short,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'amiri',
                              ),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            '${surat.revelation} - ${surat.numberOfVerses} ayat',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
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
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height / 4);
    path.lineTo(size.width, size.height * 3 / 4);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height * 3 / 4);
    path.lineTo(0, size.height / 4);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SuratSearchDelegate extends SearchDelegate<String> {
  final List<String> suratNames;
  final List<Surat> suratList;

  SuratSearchDelegate(this.suratNames, this.suratList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
           close(context, '');
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = suratList.where((surat) => surat.name.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final surat = results[index];
        return ListTile(
          title: Text(surat.name),
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

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = suratList.where((surat) => surat.name.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final surat = results[index];
        return ListTile(
          title: Text(surat.name),
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
}
