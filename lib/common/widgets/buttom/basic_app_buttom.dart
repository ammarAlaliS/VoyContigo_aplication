import 'package:flutter/material.dart';

class BasicAppButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String title;
  final double height;

  const BasicAppButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.height,
  });

  @override
  State<BasicAppButton> createState() => _BasicAppButtonState();
}

class _BasicAppButtonState extends State<BasicAppButton> {
  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(widget.height),
      ),
      child: Text(
        widget.title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
