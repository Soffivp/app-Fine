import 'package:flutter/material.dart';
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

  // === Actualizar datos de estudiante ===
  void actualizarDatosEstudiante(Map<String, dynamic> nuevosDatos) {
    _datosEstudiante.addAll(nuevosDatos);
    notifyListeners();
  }

  // === Actualizar datos de representante ===
  void actualizarDatosRepresentante(Map<String, dynamic> nuevosDatos) {
    _datosRepresentante.addAll(nuevosDatos);
    notifyListeners();
  }

  // === Actualizar datos de credenciales ===
  void actualizarCredenciales(Map<String, dynamic> nuevosDatos) {
    _datosCredenciales.addAll(nuevosDatos);
    notifyListeners();
  }

  // === Construir objetos completos ===
  Estudiante construirEstudiante() {
    return Estudiante(
      id: null, // se asigna luego en Firestore
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

  // === Guardar todo al backend ===
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

      await _guardarRegistroUseCase.execute(
        estudiante: estudiante,
        representante: representante,
        credenciales: credenciales,
      );

      _cargando = false;
      notifyListeners();
      onSuccess();
    } catch (e) {
      _cargando = false;
      notifyListeners();
      onError(e.toString());
    }
  }

  // === Limpiar todos los datos temporales ===
  void limpiarTodo() {
    _datosEstudiante.clear();
    _datosRepresentante.clear();
    _datosCredenciales.clear();
    notifyListeners();
  }
}
