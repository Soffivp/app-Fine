import 'package:flutter/material.dart';

class ProgresoRegistro extends StatelessWidget {
  final int pasoActual; // del 1 al 4

  const ProgresoRegistro({super.key, required this.pasoActual});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        final activo = index < pasoActual;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: CircleAvatar(
            radius: 8,
            backgroundColor: activo ? Colors.red : Colors.grey[300],
          ),
        );
      }),
    );
  }
}
