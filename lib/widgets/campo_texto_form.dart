import 'package:flutter/material.dart';

class CampoTextoForm extends StatelessWidget {
  final String etiqueta;
  final String valor;

  const CampoTextoForm({
    required this.etiqueta,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            etiqueta,
            style: TextStyle(
              color: Color(0xFF213354),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 6),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFD9D9D9)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              valor,
              style: TextStyle(
                color: Color(0xFFA2A1A1),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
