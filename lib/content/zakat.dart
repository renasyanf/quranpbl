import 'package:flutter/material.dart';
import 'package:quranpbl/component/header.dart';
import 'package:quranpbl/models/zakat.dart';

class ZakatCalculatorScreen extends StatefulWidget {
  @override
  _ZakatCalculatorScreenState createState() => _ZakatCalculatorScreenState();
}

class _ZakatCalculatorScreenState extends State<ZakatCalculatorScreen> {
  final ZakatCalculator _calculator = ZakatCalculator();
  final TextEditingController _wealthController = TextEditingController();
  final TextEditingController _peopleController = TextEditingController();
  final TextEditingController _ricePriceController = TextEditingController();

  double _zakatMal = 0.0;
  double _zakatFitrah = 0.0;

  void _calculateZakat() {
    setState(() {
      _zakatMal = _calculator.calculateZakatMal(double.tryParse(_wealthController.text) ?? 0);
      _zakatFitrah = _calculator.calculateZakatFitrah(
        int.tryParse(_peopleController.text) ?? 0,
        double.tryParse(_ricePriceController.text) ?? 0
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 245, 237),
      appBar: Header(title: 'Kalkulator Zakat', imagePath: 'assets/icon/zakat.png'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 10),
        TextField(
          controller: _wealthController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Total Harta (dalam mata uang)',
            border: OutlineInputBorder(), // Tambahkan border pada TextField
            filled: true,
            fillColor: Colors.grey[200], // Ubah warna latar belakang TextField
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _peopleController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Jumlah Orang (Zakat Fitrah)',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _ricePriceController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Harga Beras per kg (dalam mata uang)',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _calculateZakat,
          child: Text(
            'Hitung Zakat',
            style: TextStyle(fontSize: 18), // Ubah ukuran teks tombol
          ),
          style: ElevatedButton.styleFrom(
            primary:  Color(0xFF006769), // Ubah warna latar belakang tombol
            padding: EdgeInsets.symmetric(vertical: 12), // Tambahkan padding tombol
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Zakat Mal: ${_zakatMal.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          'Zakat Fitrah: ${_zakatFitrah.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  ),
);
  }}