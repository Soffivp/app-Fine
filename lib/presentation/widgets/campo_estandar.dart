import 'package:flutter/material.dart';

class CampoEstandar extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final List<String>? items; // Si es dropdown
  final String? value;
  final void Function(String?)? onChanged;

  // NUEVOS PARÁMETROS PARA ÍCONO DE INFORMACIÓN
  final bool iconoInfo; // ya no es nullable
  final VoidCallback? onIconPressed;
  final bool habilitado;
  final Widget? suffixIcon;
  final bool obscureText;

  const CampoEstandar({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.items,
    this.value,
    this.onChanged,
    this.iconoInfo = false, // valor por defecto: false
    this.onIconPressed,
    this.habilitado = true,
    this.suffixIcon,
    this.obscureText = false, // valor por defecto
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              if (iconoInfo)
                IconButton(
                  icon: const Icon(Icons.error_outline, color: Colors.red),
                  iconSize: 20,
                  padding: const EdgeInsets.only(left: 6),
                  constraints: const BoxConstraints(),
                  splashRadius: 18,
                  onPressed: onIconPressed,
                ),
            ],
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 52,
            child: items == null
                ? TextFormField(
              controller: controller,
              validator: validator,
              keyboardType: keyboardType,
              enabled: habilitado,
              decoration: InputDecoration(
                hintText: hintText,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            )
                : DropdownButtonFormField<String>(
              value: value,
              onChanged: onChanged,
              validator: validator,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                suffixIcon: suffixIcon, // aquí se incluye el ícono adicional si se desea
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              items: items!
                  .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
