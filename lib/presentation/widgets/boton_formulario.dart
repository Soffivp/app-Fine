import 'package:flutter/material.dart';

class BotonFormulario extends StatelessWidget {
  final String texto;
  final Color color;
  final Color textoColor;
  final Color bordeColor;
  final VoidCallback onPressed;
  final bool habilitado;

  const BotonFormulario({
    super.key,
    required this.texto,
    required this.color,
    required this.textoColor,
    required this.bordeColor,
    required this.onPressed,
    this.habilitado = true, // ✅ Valor por defecto agregado
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 100,
        maxWidth: 160,
        minHeight: 40,
        maxHeight: 48,
      ),
      child: ElevatedButton(
        onPressed: habilitado ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: habilitado ? color : Colors.grey.shade400,
          foregroundColor: textoColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: bordeColor, width: 1.5),
          ),
        ),
        child: Text(
          texto,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
