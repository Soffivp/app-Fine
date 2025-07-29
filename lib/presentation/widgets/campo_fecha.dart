import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CampoFecha extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(DateTime)? onDateSelected;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const CampoFecha({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.validator,
    this.onDateSelected,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              )),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () async {
              FocusScope.of(context).unfocus();
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: context,
                initialDate: initialDate ?? now,
                firstDate: firstDate ?? DateTime(1900),
                lastDate: lastDate ?? now,
              );

              if (picked != null) {
                final formatted = DateFormat('dd/MM/yyyy').format(picked);
                controller.text = formatted;
                onDateSelected?.call(picked);
              }
            },
            child: AbsorbPointer(
              child: SizedBox(
                height: 52,
                child: TextFormField(
                  controller: controller,
                  validator: validator,
                  decoration: InputDecoration(
                    hintText: hintText,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16),
                    suffixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
