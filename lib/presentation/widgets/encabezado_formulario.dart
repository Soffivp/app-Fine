import 'package:flutter/material.dart';

class EncabezadoFormulario extends StatelessWidget {
  final String titulo;
  final bool mostrarLogo;

  const EncabezadoFormulario({
    super.key,
    required this.titulo,
    this.mostrarLogo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (mostrarLogo)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Image.asset(
              'assets/images/imagen_margen.jpg',
              width: 200,
              fit: BoxFit.contain,
            ),
          ),
        Text(
          titulo,
          style: const TextStyle(
            color: Color(0xFF3C578A),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
