import 'package:flutter/material.dart';

class EncabezadoFormulario extends StatelessWidget {
  final String titulo;

  const EncabezadoFormulario({required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Text(
      titulo,
      style: TextStyle(
        color: Color(0xFF3C578A),
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
