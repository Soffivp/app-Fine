import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> guardarEstudianteYCredenciales({
    required String nombreUsuario,
    required String contrasena,
  }) async {
    try {
      final estudiantesRef = _firestore.collection('estudiantes');

      // Creamos un documento nuevo para el estudiante
      final nuevoEstudianteRef = await estudiantesRef.add({
        'fecha_creacion': FieldValue.serverTimestamp(),
      });

      // Creamos una subcolección "credenciales" dentro del estudiante
      await nuevoEstudianteRef.collection('credenciales').add({
        'usuario': nombreUsuario,
        'contrasena': contrasena,
        'creado_en': FieldValue.serverTimestamp(),
      });

      print("✅ Credenciales guardadas correctamente.");
    } catch (e) {
      print("❌ Error al guardar en Firestore: $e");
      rethrow;
    }
  }
}
