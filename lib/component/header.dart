import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String imagePath;
  final List<Widget>? actions;

  Header({required this.title, required this.imagePath, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF006769),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 245, 237)),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Color.fromARGB(255, 255, 245, 237),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions != null
          ? actions! + [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(imagePath, width: 65, height: 65),
              ),
            ]
          : [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(imagePath, width: 65, height: 65),
              ),
            ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
