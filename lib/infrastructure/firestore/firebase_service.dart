import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:apis/domain/entities/estudiante.dart';
import 'package:apis/domain/entities/representante.dart';
import 'package:apis/domain/entities/credenciales.dart';
import 'package:apis/domain/entities/pago.dart'; // 👈 Importa el modelo de pago

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// ✅ Método original (crea el usuario en Auth y guarda todo)
  Future<void> guardarEstudianteConTodo({
    required Estudiante estudiante,
    required Representante representante,
    required Credenciales credenciales,
  }) async {
    try {
      final emailFormateado = "${credenciales.usuario}@fineapp.com";
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailFormateado,
        password: credenciales.contrasena,
      );

      final uid = credential.user?.uid;
      if (uid == null) throw Exception('No se pudo obtener el UID del nuevo usuario');

      final estudianteRef = _firestore.collection('estudiantes').doc(uid);
      final estudianteConId = estudiante.copyWith(id: uid);

      await estudianteRef.set({
        ...estudianteConId.toJson(),
        'fecha_creacion': FieldValue.serverTimestamp(),
      });

      await estudianteRef.collection('representante').doc().set({
        ...representante.toJson(),
        'fecha_creacion': FieldValue.serverTimestamp(),
      });

      await estudianteRef.collection('credenciales').doc('login').set({
        ...credenciales.toJson(),
        'fecha_creacion': FieldValue.serverTimestamp(),
      });

      print("✅ Usuario creado y datos guardados correctamente.");
    } catch (e) {
      print("❌ Error al guardar en Firestore: $e");
      rethrow;
    }
  }

  /// ✅ Nuevo método: solo guarda en Firestore usando un UID ya existente
  Future<void> guardarEstudianteConUid({
    required String uid,
    required Estudiante estudiante,
    required Representante representante,
    required Credenciales credenciales,
  }) async {
    try {
      final estudianteRef = _firestore.collection('estudiantes').doc(uid);
      final estudianteConId = estudiante.copyWith(id: uid);

      await estudianteRef.set({
        ...estudianteConId.toJson(),
        'fecha_creacion': FieldValue.serverTimestamp(),
      });

      await estudianteRef.collection('representante').doc().set({
        ...representante.toJson(),
        'fecha_creacion': FieldValue.serverTimestamp(),
      });

      await estudianteRef.collection('credenciales').doc('login').set({
        ...credenciales.toJson(),
        'fecha_creacion': FieldValue.serverTimestamp(),
      });

      print("✅ Datos guardados correctamente para UID existente.");
    } catch (e) {
      print("❌ Error al guardar con UID existente: $e");
      rethrow;
    }
  }

  /// ✅ Nuevo método: guardar un pago en la colección 'pagos'
  Future<void> guardarPago(Pago pago) async {
    try {
      await _firestore.collection('pagos').add(pago.toJson());
      print("✅ Pago registrado correctamente en Firestore.");
    } catch (e) {
      print("❌ Error al guardar el pago: $e");
      rethrow;
    }
  }
}
