import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String imagePath;
  final String label;

  HomeButton({required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 132,
      height: 132,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF006769),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 65, height: 65),
            SizedBox(height: 14),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFFEEF0E5), fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

