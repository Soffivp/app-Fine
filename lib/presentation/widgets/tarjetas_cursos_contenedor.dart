import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'tarjetas_cursos.dart';

class TarjetasCursosContenedor extends StatelessWidget {
  final double ancho;

  const TarjetasCursosContenedor({super.key, required this.ancho});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('cursos').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final cursos = snapshot.data?.docs ?? [];

        return Column(
          children: cursos.map((doc) {
            final data = doc.data() as Map<String, dynamic>;

            return SizedBox(
              width: ancho,
              child: CursoCard(
                nombreCurso: data['nombreCurso'] ?? '',
                programa: data['programa'] ?? '',
                periodo: data['periodo'] ?? '',
                horario: data['horario'] ?? '',
                paralelo: data['paralelo'] ?? '',
                establecimiento: data['establecimiento'] ?? '',
                cupos: data['cupos'] ?? 0,
                onPressed: () {
                  Navigator.pushNamed(context, '/pago-matricula');
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
