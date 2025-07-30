import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:apis/domain/entities/estudiante.dart';
import 'package:apis/domain/entities/representante.dart';
import 'package:apis/domain/entities/credenciales.dart';
import 'package:apis/domain/use_cases/guardar_registro_use_case.dart';

class RegistroProvider extends ChangeNotifier {
  final GuardarRegistroUseCase _guardarRegistroUseCase;

  RegistroProvider(this._guardarRegistroUseCase);

  bool _cargando = false;
  bool get cargando => _cargando;

  // === Datos temporales ===
  Map<String, dynamic> _datosEstudiante = {};
  Map<String, dynamic> _datosRepresentante = {};
  Map<String, dynamic> _datosCredenciales = {};

  Map<String, dynamic> get datosEstudiante => _datosEstudiante;
  Map<String, dynamic> get datosRepresentante => _datosRepresentante;
  Map<String, dynamic> get datosCredenciales => _datosCredenciales;

  void actualizarDatosEstudiante(Map<String, dynamic> nuevosDatos) {
    _datosEstudiante.addAll(nuevosDatos);
    notifyListeners();
  }

  void actualizarDatosRepresentante(Map<String, dynamic> nuevosDatos) {
    _datosRepresentante.addAll(nuevosDatos);
    notifyListeners();
  }

  void actualizarCredenciales(Map<String, dynamic> nuevosDatos) {
    _datosCredenciales.addAll(nuevosDatos);
    notifyListeners();
  }

  Estudiante construirEstudiante() {
    return Estudiante(
      id: null,
      tipoIdentificacion: _datosEstudiante['tipoIdentificacion'],
      numIdentificacion: _datosEstudiante['numIdentificacion'],
      nombre: _datosEstudiante['nombre'],
      apellido: _datosEstudiante['apellido'],
      fechaNacimiento: _datosEstudiante['fechaNacimiento'],
      genero: _datosEstudiante['genero'],
      ocupacion: _datosEstudiante['ocupacion'],
      nivelEducacion: _datosEstudiante['nivelEducacion'],
      lugarEstudioTrabajo: _datosEstudiante['lugarEstudioTrabajo'],
      direccion: _datosEstudiante['direccion'],
      correo: _datosEstudiante['correo'],
      celular: _datosEstudiante['celular'],
      telefono: _datosEstudiante['telefono']?.isEmpty ?? true ? null : _datosEstudiante['telefono'],
      establecimiento: _datosEstudiante['establecimiento'],
      programaAcademico: _datosEstudiante['programaAcademico'],
      esRepresentante: _datosEstudiante['esRepresentante'] ?? false,
    );
  }

  Representante construirRepresentante() {
    return Representante(
      emitirFacturaAlEstudiante: _datosRepresentante['emitirFacturaAlEstudiante'] ?? false,
      tipoIdentificacion: _datosRepresentante['tipoIdentificacion'] ?? '',
      numeroIdentificacion: _datosRepresentante['numeroIdentificacion'] ?? '',
      nombreCompleto: _datosRepresentante['razonSocial/NombreCompleto'] ?? '',
      origenIngresos: _datosRepresentante['origenIngresos'] ?? '',
      parroquia: _datosRepresentante['parroquia'] ?? '',
      estadoCivil: _datosRepresentante['estadoCivil'] ?? '',
      genero: _datosRepresentante['genero'] ?? '',
      direccion: _datosRepresentante['direccion'] ?? '',
      correo: _datosRepresentante['correo'] ?? '',
      celular: _datosRepresentante['celular'] ?? '',
      telefono: _datosRepresentante['telefono'] ?? '',
    );
  }

  Credenciales construirCredenciales() {
    return Credenciales(
      usuario: _datosCredenciales['usuario'],
      contrasena: _datosCredenciales['contrasena'],
    );
  }

  Future<void> guardarTodo({
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    _cargando = true;
    notifyListeners();

    try {
      final estudiante = construirEstudiante();
      final representante = construirRepresentante();
      final credenciales = construirCredenciales();

      print('👤 Estudiante: ${estudiante.toJson()}');
      print('👨‍👩‍👧 Representante: ${representante.toJson()}');
      print('🔐 Credenciales: ${credenciales.toJson()}');

      final usuarioPlano = credenciales.usuario.trim();
      final correoParaAuth = '$usuarioPlano@fineapp.com';

      // 👉 Paso 1: Crear usuario en Firebase Auth
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: correoParaAuth,
        password: credenciales.contrasena,
      );

      final uid = credential.user?.uid;
      if (uid == null) throw Exception('No se pudo obtener el UID');

      // 👉 Paso 2: Guardar en Firestore usando el UID
      await _guardarRegistroUseCase.executeConUid(
        uid: uid,
        estudiante: estudiante.copyWith(id: uid),
        representante: representante,
        credenciales: Credenciales(
          usuario: usuarioPlano,
          contrasena: credenciales.contrasena,
        ),
      );

      _cargando = false;
      notifyListeners();
      onSuccess();
    } catch (e, stacktrace) {
      print('🛑 Error al registrar: $e');
      print('📍 Stacktrace: $stacktrace');

      // 🔁 Rollback seguro
      try {
        final auth = FirebaseAuth.instance;
        final user = auth.currentUser;

        if (user != null && user.uid.isNotEmpty) {
          await user.delete();
          print('🧹 Usuario Auth eliminado por error posterior');
        } else {
          print('⚠️ No se pudo eliminar usuario: user es null o sin UID');
        }
      } catch (deleteError) {
        print('⚠️ Error seguro al intentar eliminar usuario Auth: $deleteError');
      }

      _cargando = false;
      notifyListeners();
      onError('Ocurrió un error al registrar. Inténtalo nuevamente.');
    }
  }

  void limpiarTodo() {
    _datosEstudiante.clear();
    _datosRepresentante.clear();
    _datosCredenciales.clear();
    notifyListeners();
  }
}
