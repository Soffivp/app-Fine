// archivo: presentation/widgets/boton_atras.dart
import 'package:flutter/material.dart';

class BotonAtras extends StatelessWidget {
  final VoidCallback? onPressed;

  const BotonAtras({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: const Color(0xFF1C2C4C),
          onPressed: onPressed ?? () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
