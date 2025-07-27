import 'package:cloud_firestore/cloud_firestore.dart';

class DatosEstudiante {
  final String nombre;
  final String apellido;
  final String cedula;
  final String telefono;
  final String correo;
  final String direccion;
  final String nombreRepresentante;
  final String telefonoRepresentante;

  DatosEstudiante({
    required this.nombre,
    required this.apellido,
    required this.cedula,
    required this.telefono,
    required this.correo,
    required this.direccion,
    required this.nombreRepresentante,
    required this.telefonoRepresentante,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'cedula': cedula,
      'telefono': telefono,
      'correo': correo,
      'direccion': direccion,
      'representante': {
        'nombre': nombreRepresentante,
        'telefono': telefonoRepresentante,
      },
      'fecha_creacion': FieldValue.serverTimestamp(),
    };
  }
}
