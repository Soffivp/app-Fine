import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apis/presentation/providers/estudiante_provider.dart';

class CuadroAInfo extends StatelessWidget {
  const CuadroAInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final estudiante = context.watch<EstudianteProvider>().estudiante;

    if (estudiante == null) {
      return const Text('No hay datos del estudiante cargados.');
    }

    final nombre = '${estudiante.nombre} ${estudiante.apellido}';
    final cedula = estudiante.numIdentificacion;
    final correo = estudiante.correo;
    final programa = estudiante.programaAcademico;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFD0DAF2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.person_outline, size: 40, color: Colors.black87),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nombre,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black87,
                    )),
                Text('Nro. Cdl: $cedula',
                    style: const TextStyle(fontSize: 13)),
                if (programa.isNotEmpty)
                  Text(programa, style: const TextStyle(fontSize: 13)),
                if (correo.isNotEmpty)
                  Text(correo, style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/detalle_estudiante');
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black87,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(40, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  children: const [
                    Text("Ver más", style: TextStyle(fontSize: 13)),
                    SizedBox(width: 4),
                    Icon(Icons.chevron_right, size: 20),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
