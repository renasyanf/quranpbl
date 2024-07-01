import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:quranpbl/component/header.dart';
import '../models/surat.dart';
import '../models/ayat.dart';
import '../services/ayat.dart';
import 'package:audioplayers/audioplayers.dart';

class OctagonNumber extends StatelessWidget {
  final String number;
  final double size;
  final Color color;
  final TextStyle textStyle;

  OctagonNumber({
    required this.number,
    this.size = 24.0,
    this.color = Colors.blue,
    this.textStyle = const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _OctagonPainter(number: number, color: color, textStyle: textStyle),
    );
  }
}

class _OctagonPainter extends CustomPainter {
  final String number;
  final Color color;
  final TextStyle textStyle;

  _OctagonPainter({
    required this.number,
    required this.color,
    required this.textStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double side = size.width / 2;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = side / cos(pi / 8);

    // Draw octagon
    Path octagonPath = Path();
    octagonPath.moveTo(centerX + side, centerY);
    for (int i = 1; i < 8; i++) {
      double angle = i * pi / 4;
      octagonPath.lineTo(centerX + radius * cos(angle), centerY + radius * sin(angle));
    }
    octagonPath.close();
    canvas.drawPath(octagonPath, Paint()..color = color);

    // Draw number inside the octagon
    TextPainter textPainter = TextPainter(
      text: TextSpan(text: number, style: textStyle),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(centerX - textPainter.width / 2, centerY - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SuratPage extends StatefulWidget {
  final Surat surat;

  SuratPage({required this.surat});

  @override
  _SuratPageState createState() => _SuratPageState();
}

class _SuratPageState extends State<SuratPage> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = '';
  double _confidence = 1.0;

  String _recitationStatus = '';
  AudioPlayer _audioPlayer = AudioPlayer();
  String? _playingAyat;
  String? _listeningAyat; // ID ayat yang sedang didengarkan

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _scrollController.dispose();
    _audioPlayer.dispose();
    _speech.stop(); // Stop SpeechToText instance on dispose
    super.dispose();
  }

  Future<String> correctText(String text) async {
    List<String> verses = await fetchQuranText();
    String correctedText = text;
    for (String verse in verses) {
      if (text.contains(verse)) {
        correctedText = text.replaceAll(verse, '');
        break;
      }
    }
    return correctedText;
  }

  Future<List<String>> fetchQuranText() async {
    try {
      String data = await DefaultAssetBundle.of(context).loadString('assets/data/data.json');
      Map<String, dynamic> surahs = jsonDecode(data);
      List<String> allVerses = [];

      surahs.forEach((surahKey, surahValue) {
        surahValue.forEach((ayahKey, ayahValue) {
          allVerses.add(ayahValue['text']);
        });
      });

      return allVerses;
    } catch (e) {
      print('Error loading Quranic verses: $e');
      return [];
    }
  }

  void _listen(String ayah) async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() {
          _isListening = true;
          _listeningAyat = ayah;
          _recitationStatus = '';
          _text = 'Listening...';
        });

        // Stop any playing audio if exists
        if (_audioPlayer.state == PlayerState.playing || _audioPlayer.state == PlayerState.paused) {
          await _audioPlayer.stop();
          setState(() {
            _playingAyat = null;
          });
        }

        _speech.listen(
          onResult: (val) async {
            setState(() {
              _text = val.recognizedWords;
              if (val.hasConfidenceRating && val.confidence > 0) {
                _confidence = val.confidence;
              }
            });
            String correctedText = await correctText(_text);
            setState(() {
              _recitationStatus = _text == correctedText ? 'Correct Reading' : 'Incorrect Reading';
            });
          },
          localeId: 'ar',
          cancelOnError: true,
          partialResults: false,
          listenFor: Duration(seconds: 5),
          pauseFor: Duration(seconds: 5),
        );
      }
    } else {
      setState(() {
        _isListening = false;
        _listeningAyat = null;
        _recitationStatus = '';
        _text = '';
        _speech.stop();
      });

      // Stop playing audio if speech recognition is stopped
      if (_audioPlayer.state == PlayerState.playing || _audioPlayer.state == PlayerState.paused) {
        await _audioPlayer.stop();
        setState(() {
          _playingAyat = null;
        });
      }
    }
  }

  void _playAudio(String ayah, String audioUrl) async {
    if (_playingAyat == ayah) {
      await _audioPlayer.pause();
      setState(() {
        _playingAyat = null;
      });
    } else {
      // Ensure audio is stopped before playing new audio
      if (_audioPlayer.state == PlayerState.playing) {
        await _audioPlayer.stop();
      }

      await _audioPlayer.play(DeviceFileSource(audioUrl)); // Adjust according to your audio source
      setState(() {
        _playingAyat = ayah;
      });

      _audioPlayer.onPlayerComplete.listen((event) {
        setState(() {
          _playingAyat = null;
        });
      });
    }
  }


  String convertToPentagonArabicNumber(String number) {
    List<String> pentagonArabicNumbers = [
      '\u0660',
      '\u0661',
      '\u0662',
      '\u0663',
      '\u0664',
      '\u0665',
      '\u0666',
      '\u0667',
      '\u0668',
      '\u0669'
    ];
    String pentagonArabicNumber = '';
    List<int> digits = number.codeUnits.map((e) => e - 48).toList();
    for (int digit in digits) {
      pentagonArabicNumber += pentagonArabicNumbers[digit];
    }
    return pentagonArabicNumber;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Ensure to call super.build(context) when using AutomaticKeepAliveClientMixin

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Baca Quran', imagePath: 'assets/icon/quran.png'),
      body: FutureBuilder<List<Ayat>>(
        future: AyatService().fetchAyatList(widget.surat.number),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            final ayatList = snapshot.data!;
            return InteractiveViewer(
              panEnabled: true,
              boundaryMargin: EdgeInsets.all(20.0),
              minScale: 0.5,
              maxScale: 4.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.surat.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromARGB(255, 134, 109, 91),
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${widget.surat.numberOfVerses} - ${widget.surat.revelation}',
                              style: TextStyle(fontSize: 14, color: Color(0xFFC7B7A3)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      itemCount: ayatList.length,
                      itemBuilder: (context, index) {
                        final ayat = ayatList[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 245, 237), // Unified background color
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0xFF006769), width: 1),
                          ),
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                title: Row(
                                  children: [
                                    OctagonNumber(
                                      number: convertToPentagonArabicNumber(ayat.ayah),
                                      size: 24.0,
                                      color: Color(0xFF006769),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        _playingAyat == ayat.ayah
                                            ? Icons.pause
                                            : Icons.volume_up,
                                        color: Color(0xFF006769),
                                      ),
                                      onPressed: () {
                                        _playAudio(ayat.ayah, ayat.audio);
                                      },
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        ayat.arab,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontFamily: 'amiri', fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 2),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  ayat.text,
                                  style: TextStyle(fontFamily: 'amiri', fontSize: 18, color: Color(0xFF000000)),
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      _listeningAyat == ayat.ayah ? Icons.mic : Icons.mic_none,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      _listen(ayat.ayah);
                                    },
                                  ),
                                  SizedBox(width: 8),
                                   if (_listeningAyat == ayat.ayah)
                                  Expanded(
                                    child: Text(                                     
                                      _text,
                                      style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                   if (_listeningAyat == ayat.ayah)
                                  Expanded(
                                    child: Text(
                                      
                                      _recitationStatus,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: _recitationStatus == 'Correct Reading'
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
