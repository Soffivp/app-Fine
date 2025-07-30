import 'package:flutter/material.dart';

class CursoCard extends StatelessWidget {
  final String nombreCurso;
  final String programa;
  final String periodo;
  final String horario;
  final String paralelo;
  final String establecimiento;
  final int cupos;
  final VoidCallback onPressed;

  const CursoCard({
    super.key,
    required this.nombreCurso,
    required this.programa,
    required this.periodo,
    required this.horario,
    required this.paralelo,
    required this.establecimiento,
    required this.cupos,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2D5D),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título e ícono
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  nombreCurso.isNotEmpty ? nombreCurso : "Sin nombre",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              const Icon(Icons.info_outline, color: Colors.white),
            ],
          ),

          const SizedBox(height: 14),

          // Info detallada

          Text("Programa: $programa", style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 10),
          Text("Periodo: $periodo", style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 10),
          Text("Horario: $horario", style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 10),
          Text("Paralelo: $paralelo", style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 10),
          Text("Establecimiento: $establecimiento", style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 10),
          Text("Cupos: $cupos", style: const TextStyle(color: Colors.white)),

          const SizedBox(height: 22),

          // Botón centrado y ancho completo
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF1C2D5D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                "Solicitar Inscripción",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
