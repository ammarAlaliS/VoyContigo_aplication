import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final bool isDarkMode;

  const CustomTitle({Key? key, required this.title, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: -1.6,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
}
