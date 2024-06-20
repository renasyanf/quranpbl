import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:just_audio/just_audio.dart';
import '../DbHelper.dart'; // Adjust the path as per your project structure
import 'package:quranpbl/component/header.dart'; // Adjust the path as per your project structure

class Hijaiyah extends StatefulWidget {
  @override
  _HijaiyahState createState() => _HijaiyahState();
}

class _HijaiyahState extends State<Hijaiyah> {
  late Future<Map<String, List<String>>> _dataFuture;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _dataFuture = _loadData();
    _audioPlayer = AudioPlayer();
  }

  Future<Map<String, List<String>>> _loadData() async {
    await DbHelper.copyDatabase('pbl.db');
    Database database = await openDatabase('pbl.db');

    List<Map> imageResult = await database.rawQuery('SELECT path_gambar FROM gambar WHERE id BETWEEN 1 AND 30');
    List<String> imageList = imageResult.map((e) => e['path_gambar'] as String).toList();

    List<Map> audioResult = await database.rawQuery('SELECT audios FROM gambar WHERE id BETWEEN 1 AND 30');
    List<String> audioList = audioResult.map((e) => e['audios'] as String).toList();

    await database.close();

    return {
      'images': imageList,
      'audios': audioList,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(
        title: 'Huruf Hijaiyah', 
        imagePath: 'assets/icon/hijaiyah.png',
      ),
      body: FutureBuilder<Map<String, List<String>>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            final imageList = snapshot.data!['images']!;
            final audioList = snapshot.data!['audios']!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: imageList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0, // Spacing between columns
                  mainAxisSpacing: 4.0, // Spacing between rows
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _playAudio(audioList[index]); // Call _playAudio function when image is tapped
                    },
                    child: Image.asset(
                      'assets/hijaiyah/${imageList[index]}',
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

  void _playAudio(String audioPath) async {
    try {
      await _audioPlayer.setAsset('assets/audios/$audioPath');
      await _audioPlayer.play();
    } catch (e) {
      print('Failed to play audio: $e');
      // Handle more specific error cases if needed
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Clean up resources used by AudioPlayer
    super.dispose();
  }
}
