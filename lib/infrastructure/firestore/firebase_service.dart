import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:apis/domain/entities/estudiante.dart';
import 'package:apis/domain/entities/representante.dart';
import 'package:apis/domain/entities/credenciales.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> guardarEstudianteConTodo({
    required Estudiante estudiante,
    required Representante representante,
    required Credenciales credenciales,
  }) async {
    try {
      // 1. Crear documento del estudiante y obtener la referencia
      final estudianteRef = _firestore.collection('estudiantes').doc();

      // 2. Crear una copia del estudiante con el ID incluido
      final estudianteConId = estudiante.copyWith(id: estudianteRef.id);

      // 3. Guardar estudiante con su ID
      await estudianteRef.set(estudianteConId.toJson());

      // 4. Agregar representante en subcolección
      await estudianteRef
          .collection('representante')
          .doc()
          .set(representante.toJson());

      // 5. Agregar credenciales en subcolección "credenciales/login"
      await estudianteRef
          .collection('credenciales')
          .doc('login')
          .set(credenciales.toJson());

      print("✅ Estudiante, representante y credenciales guardados.");
    } catch (e) {
      print("❌ Error al guardar en Firestore: $e");
      rethrow;
    }
  }

}
