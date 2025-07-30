import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TarjetasNoticias extends StatelessWidget {
  const TarjetasNoticias({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C2D5D),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'Anuncios Académicos',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 260,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('anuncios').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return const Center(child: Text('Error al cargar datos.'));
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                final docs = snapshot.data!.docs;
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    return _TarjetaNoticia(
                      titulo: data['Titulo'] ?? 'Sin título',
                      descripcion: data['Descripcion'] ?? 'Sin descripción',
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TarjetaNoticia extends StatelessWidget {
  final String titulo;
  final String descripcion;

  const _TarjetaNoticia({
    required this.titulo,
    required this.descripcion,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF5F5F5),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFE51F52),
          child: Icon(Icons.priority_high, color: Colors.white),
        ),
        title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(descripcion),
        trailing: const Text('Ver más', style: TextStyle(color: Colors.black87)),
        onTap: () {
          // No funcionalidad por ahora
        },
      ),
    );
  }
}
