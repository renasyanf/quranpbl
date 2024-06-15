import 'package:flutter/material.dart';
import 'package:quranpbl/component/header.dart';
import 'package:sqflite/sqflite.dart';
import '../DbHelper.dart';

class Tajwid1 extends StatefulWidget {
  @override
  _Tajwid1State createState() => _Tajwid1State();
}

class _Tajwid1State extends State<Tajwid1> {
  Future<List<String>> getImages() async {
    await DbHelper.copyDatabase('pbl.db');
    Database database = await openDatabase('pbl.db');

    List<Map> result = await database.rawQuery('SELECT path_gambar FROM gambar WHERE id BETWEEN 49 AND 53');

    List<String> imageList = result.map((e) => e['path_gambar'] as String).toList();

    await database.close();
    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Nun Sukun dan Tanwin', imagePath: 'assets/icon/TAJWID.png'),
      body: FutureBuilder<List<String>>(
        future: getImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            final imageList = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Image.asset(
                        'assets/tajwid/${imageList[index]}',
                        fit: BoxFit.cover, // Adjust the fit to cover the container
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

// gunnah
class Tajwid2 extends StatefulWidget {
  @override
  _Tajwid2State createState() => _Tajwid2State();
}

class _Tajwid2State extends State<Tajwid2> {
  Future<List<String>> getImages() async {
    await DbHelper.copyDatabase('pbl.db');
    Database database = await openDatabase('pbl.db');

    List<Map> result = await database.rawQuery('SELECT path_gambar FROM gambar WHERE id=54');

    List<String> imageList = result.map((e) => e['path_gambar'] as String).toList();

    await database.close();
    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Gunnah', imagePath: 'assets/icon/TAJWID.png'),
      body: FutureBuilder<List<String>>(
        future: getImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            final imageList = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Image.asset(
                        'assets/tajwid/${imageList[index]}',
                        fit: BoxFit.cover, // Adjust the fit to cover the container
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

// macam macam idghom
class Tajwid3 extends StatefulWidget {
  @override
  _Tajwid3State createState() => _Tajwid3State();
}

class _Tajwid3State extends State<Tajwid3> {
  Future<List<String>> getImages() async {
    await DbHelper.copyDatabase('pbl.db');
    Database database = await openDatabase('pbl.db');

    List<Map> result = await database.rawQuery('SELECT path_gambar FROM gambar WHERE id BETWEEN 55 AND 57');

    List<String> imageList = result.map((e) => e['path_gambar'] as String).toList();

    await database.close();
    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Macam-macam Idghom', imagePath: 'assets/icon/TAJWID.png'),
      body: FutureBuilder<List<String>>(
        future: getImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            final imageList = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Image.asset(
                        'assets/tajwid/${imageList[index]}',
                        fit: BoxFit.cover, // Adjust the fit to cover the container
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


// lam ta'rif
class Tajwid4 extends StatefulWidget {
  @override
  _Tajwid4State createState() => _Tajwid4State();
}

class _Tajwid4State extends State<Tajwid4> {
  Future<List<String>> getImages() async {
    await DbHelper.copyDatabase('pbl.db');
    Database database = await openDatabase('pbl.db');

    List<Map> result = await database.rawQuery('SELECT path_gambar FROM gambar WHERE id BETWEEN 58 AND 59');

    List<String> imageList = result.map((e) => e['path_gambar'] as String).toList();

    await database.close();
    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Hukum Lam Ta\'rif', imagePath: 'assets/icon/TAJWID.png'),
      body: FutureBuilder<List<String>>(
        future: getImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            final imageList = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Image.asset(
                        'assets/tajwid/${imageList[index]}',
                        fit: BoxFit.cover, // Adjust the fit to cover the container
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

// qolqolah
class Tajwid5 extends StatefulWidget {
  @override
  _Tajwid5State createState() => _Tajwid5State();
}

class _Tajwid5State extends State<Tajwid5> {
  Future<List<String>> getImages() async {
    await DbHelper.copyDatabase('pbl.db');
    Database database = await openDatabase('pbl.db');

    List<Map> result = await database.rawQuery('SELECT path_gambar FROM gambar WHERE id BETWEEN 60 AND 61');

    List<String> imageList = result.map((e) => e['path_gambar'] as String).toList();

    await database.close();
    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Qolqolah', imagePath: 'assets/icon/TAJWID.png'),
      body: FutureBuilder<List<String>>(
        future: getImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            final imageList = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Image.asset(
                        'assets/tajwid/${imageList[index]}',
                        fit: BoxFit.cover, // Adjust the fit to cover the container
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

// mimsukun
class Tajwid6 extends StatefulWidget {
  @override
  _Tajwid6State createState() => _Tajwid6State();
}

class _Tajwid6State extends State<Tajwid6> {
  Future<List<String>> getImages() async {
    await DbHelper.copyDatabase('pbl.db');
    Database database = await openDatabase('pbl.db');

    List<Map> result = await database.rawQuery('SELECT path_gambar FROM gambar WHERE id BETWEEN 62 AND 64');

    List<String> imageList = result.map((e) => e['path_gambar'] as String).toList();

    await database.close();
    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Mim Sukun', imagePath: 'assets/icon/TAJWID.png'),
      body: FutureBuilder<List<String>>(
        future: getImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            final imageList = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Image.asset(
                        'assets/tajwid/${imageList[index]}',
                        fit: BoxFit.cover, // Adjust the fit to cover the container
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