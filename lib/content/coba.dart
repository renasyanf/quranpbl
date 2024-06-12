import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SuratPage(),
  ));
}

class SuratPage extends StatefulWidget {
  @override
  _SuratPageState createState() => _SuratPageState();
}

class _SuratPageState extends State<SuratPage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _recognizedText = '';
  String _displayText = '';
  String _recognitionStatus = '';

  // Mapping harakat untuk setiap huruf hijaiyah
  Map<String, List<String>> _harakat = {
    'ا': ['\u0652', '\u064E', '\u064B'], // Alif: sukun, fathah, fathatain
    'ب': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Ba: sukun, fathah, dhammah, kasrah, syaddah, fathatain, dhammatain, kasratain
    'ت': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Ta
    'ث': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Tha
    'ج': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Jim
    'ح': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Ha
    'خ': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Kha
    'د': ['\u0652', '\u064E', '\u064F', '\u0650', '\u064B', '\u064C', '\u064D'], // Dal
    'ذ': ['\u0652', '\u064E', '\u064F', '\u0650', '\u064B', '\u064C', '\u064D'], // Dzal
    'ر': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Ra
    'ز': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Zain
    'س': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Sin
    'ش': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Syin
    'ص': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Shad
    'ض': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Dad
    'ط': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Tha
    'ظ': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Dzha
    'ع': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Ain
    'غ': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Ghain
    'ف': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Fa
    'ق': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Qaf
    'ك': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Kaf
    'ل': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Lam
    'م': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Mim
    'ن': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Nun
    'ه': ['\u0652', '\u064E', '\u064F', '\u0650', '\u0651', '\u064B', '\u064C', '\u064D'], // Ha
    'و': ['\u0652', '\u064F', '\u064B', '\u064C'], // Waw: sukun, dhammah, dhammatain
    'ي': ['\u0652', '\u0650', '\u064B', '\u064D'], // Ya: sukun, kasrah, fathatain, kasratain
  };

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() {
          _isListening = true;
          _recognitionStatus = 'Listening...';
          _recognizedText = '';
          _displayText = '';
        });
        _speech.listen(
          onResult: (result) async {
            setState(() {
              _recognizedText = result.recognizedWords;
              _recognitionStatus = 'Recognized Text: $_recognizedText';
            });
            String textWithDiacritics = await addDiacriticsToText(_recognizedText);
            setState(() {
              _displayText = textWithDiacritics;
            });
          },
          localeId: 'ar-EG',
        );
      }
    } else {
      setState(() {
        _isListening = false;
        _recognitionStatus = '';
        _speech.stop();
      });
    }
  }

  Future<String> addDiacriticsToText(String text) async {
    StringBuffer textWithDiacritics = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      String currentChar = text[i];
      String diacritic = await _getDiacriticFor(
        currentChar,
        i > 0 ? text[i - 1] : null,
        i < text.length - 1 ? text[i + 1] : null,
      );
      textWithDiacritics.write(currentChar + diacritic);
    }

    return textWithDiacritics.toString();
  }

  Future<String> _getDiacriticFor(String character, String? previousChar, String? nextChar) async {
    if (_harakat.containsKey(character)) {
      // Aturan penentuan harakat
      if (previousChar == null) {
        // Jika karakter pertama, tambahkan fathah
        return '\u064E';
      } else if (_isConsonant(previousChar) && (nextChar == null || _isConsonant(nextChar))) {
        // Jika diapit oleh konsonan, tambahkan sukun
        return '\u0652';
      } else if (nextChar != null && _isVowel(nextChar)) {
        // Jika diikuti oleh vokal, tambahkan kasrah
        return '\u0650';
      } else {
        // Default ke fathah jika tidak ada aturan khusus
        return '\u064E';
      }
    } else {
      return ''; // Jika karakter bukan huruf hijaiyah, tidak ada harakat
    }
  }

  bool _isVowel(String character) {
    return 'اوي'.contains(character);
  }

  bool _isConsonant(String character) {
    return 'بتثجحخدذرزسشصضطظعغفقكلمنه'.contains(character);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech to Text with Diacritics'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _recognitionStatus,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              _displayText,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _listen,
              child: Icon(
                _isListening ? Icons.mic : Icons.mic_none,
                size: 36,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
