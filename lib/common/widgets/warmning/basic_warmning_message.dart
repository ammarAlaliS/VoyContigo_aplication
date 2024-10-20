import 'package:flutter/material.dart';

class BasicWarningMessage extends StatelessWidget {
  final String text; 
  final Color borderColor; 
  final Color bgColor;
  final double letterHeight; 

  const BasicWarningMessage({
    super.key,
    required this.text,
    required this.borderColor,
    required this.bgColor, 
    required this.letterHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: borderColor,
   
          ),
        ),
      ),
    );
  }
}

