import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotiEventos extends StatelessWidget {
  const NotiEventos({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('eventos').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No hay eventos disponibles.'));
        }

        final eventos = snapshot.data!.docs;

        return ListView.builder(
          itemCount: eventos.length,
          itemBuilder: (context, index) {
            final evento = eventos[index].data() as Map<String, dynamic>;
            final titulo = evento['Titulo'] ?? '';
            final descripcion = evento['Descripcion'] ?? '';
            final fecha = evento['Fecha'] ?? '';
            final lugar = evento['Lugar'] ?? '';

            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.warning_amber_rounded, color: Colors.red),
                        SizedBox(width: 8),
                        Text(
                          "Evento",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      titulo,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(descripcion),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16),
                        const SizedBox(width: 4),
                        Expanded(child: Text(fecha.toString())),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16),
                        const SizedBox(width: 4),
                        Expanded(child: Text(lugar)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("Ver más"),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
