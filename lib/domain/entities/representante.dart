import 'package:cloud_firestore/cloud_firestore.dart';

class Representante {
  final bool emitirFacturaAlEstudiante;
  final String tipoIdentificacion;
  final String numeroIdentificacion;
  final String nombreCompleto;
  final String origenIngresos;
  final String parroquia;
  final String estadoCivil;
  final String genero;
  final String direccion;
  final String correo;
  final String celular;
  final String? telefono;

  Representante({
    required this.emitirFacturaAlEstudiante,
    required this.tipoIdentificacion,
    required this.numeroIdentificacion,
    required this.nombreCompleto,
    required this.origenIngresos,
    required this.parroquia,
    required this.estadoCivil,
    required this.genero,
    required this.direccion,
    required this.correo,
    required this.celular,
    this.telefono,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'emitirFacturaAlEstudiante': emitirFacturaAlEstudiante,
      'tipoIdentificacion': tipoIdentificacion,
      'numeroIdentificacion': numeroIdentificacion,
      'nombreCompleto': nombreCompleto,
      'origenIngresos': origenIngresos,
      'parroquia': parroquia,
      'estadoCivil': estadoCivil,
      'genero': genero,
      'direccion': direccion,
      'correo': correo,
      'celular': celular,
      'fecha_creacion': FieldValue.serverTimestamp(),
    };

    // Añadir 'telefono' solo si no es null ni vacío
    if (telefono != null && telefono!.trim().isNotEmpty) {
      data['telefono'] = telefono!;
    }

    return data;
  }
}
