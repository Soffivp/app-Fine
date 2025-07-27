import 'package:flutter/material.dart';

class BotonFormulario extends StatelessWidget {
  final String texto;
  final Color color;
  final Color textoColor;
  final Color bordeColor;
  final VoidCallback onPressed;

  const BotonFormulario({
    required this.texto,
    required this.color,
    required this.textoColor,
    required this.bordeColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textoColor,
        padding: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: bordeColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        texto,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
