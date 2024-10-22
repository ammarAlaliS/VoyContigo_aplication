import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double height;
  final Color? backgroundColor; // Color de fondo (opcional, puede ser null)
  final Color textColor; // Color del texto
  final Color? borderColor; // Color del borde

  const BasicAppButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.height,
    this.backgroundColor, // Ahora es opcional
    this.textColor = Colors.white, // Color de texto predeterminado
    this.borderColor, // Color del borde por defecto
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor, // Asignar color de fondo
        minimumSize: Size.fromHeight(height),
        textStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.045, // Tamaño reactivo
          letterSpacing: -1,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor ?? Colors.black.withOpacity(0.2), width: 1), // Define el borde
          borderRadius: BorderRadius.circular(9999), // Borde completamente circular
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: textColor, // Asignar color de texto
        ),
      ),
    );
  }
}
