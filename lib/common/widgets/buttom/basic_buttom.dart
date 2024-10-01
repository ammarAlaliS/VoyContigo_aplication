// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BasicButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String title;
  final double height;
  final IconData? icon; 

  const BasicButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.height,
    this.icon, 
  });

  @override
  State<BasicButton> createState() => _BasicAppButtonState();
}

class _BasicAppButtonState extends State<BasicButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(widget.height),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.icon != null)
            Icon(
              widget.icon,
              color: Colors.black, 
            ),
          if (widget.icon != null)
            SizedBox(width: 5), 
          Text(
            widget.title,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
