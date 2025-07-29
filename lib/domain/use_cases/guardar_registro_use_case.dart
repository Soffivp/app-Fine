import 'package:apis/domain/entities/credenciales.dart';
import 'package:apis/domain/entities/estudiante.dart';
import 'package:apis/domain/entities/representante.dart';
import 'package:apis/infrastructure/firestore/firebase_service.dart';

class GuardarRegistroUseCase {
  final FirebaseService _firebaseService;

  GuardarRegistroUseCase(this._firebaseService);

  Future<void> execute({
    required Estudiante estudiante,
    required Representante representante,
    required Credenciales credenciales,
  }) async {
    await _firebaseService.guardarEstudianteConTodo(
      estudiante: estudiante,
      representante: representante,
      credenciales: credenciales,
    );
  }
}
