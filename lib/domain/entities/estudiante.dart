import 'package:cloud_firestore/cloud_firestore.dart';

class Estudiante {
  final String? id;
  final String tipoIdentificacion;
  final String numIdentificacion;
  final String nombre;
  final String apellido;
  final DateTime fechaNacimiento;
  final String genero;
  final String ocupacion;
  final String nivelEducacion;
  final String lugarEstudioTrabajo;
  final String direccion;
  final String correo;
  final String celular;
  final String? telefono;
  final String establecimiento;
  final String programaAcademico;
  final bool esRepresentante;

  Estudiante({
    this.id,
    required this.tipoIdentificacion,
    required this.numIdentificacion,
    required this.nombre,
    required this.apellido,
    required this.fechaNacimiento,
    required this.genero,
    required this.ocupacion,
    required this.nivelEducacion,
    required this.lugarEstudioTrabajo,
    required this.direccion,
    required this.correo,
    required this.celular,
    this.telefono,
    required this.establecimiento,
    required this.programaAcademico,
    this.esRepresentante = false,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'tipoIdentificacion': tipoIdentificacion,
      'numIdentificacion': numIdentificacion,
      'nombre': nombre,
      'apellido': apellido,
      'fechaNacimiento': Timestamp.fromDate(fechaNacimiento),
      'genero': genero,
      'ocupacion': ocupacion,
      'nivelEducacion': nivelEducacion,
      'lugarEstudioTrabajo': lugarEstudioTrabajo,
      'direccion': direccion,
      'correo': correo,
      'celular': celular,
      'establecimiento': establecimiento,
      'programaAcademico': programaAcademico,
      'esRepresentante': esRepresentante,
      'fecha_creacion': FieldValue.serverTimestamp(),
    };

    // Solo añade 'telefono' si no es null ni vacío
    if (telefono != null && telefono!.trim().isNotEmpty) {
      data['telefono'] = telefono!;
    }

    return data;
  }

  Estudiante copyWith({
    String? id,
    String? tipoIdentificacion,
    String? numIdentificacion,
    String? nombre,
    String? apellido,
    DateTime? fechaNacimiento,
    String? genero,
    String? ocupacion,
    String? nivelEducacion,
    String? lugarEstudioTrabajo,
    String? direccion,
    String? correo,
    String? celular,
    String? telefono,
    String? establecimiento,
    String? programaAcademico,
  }) {
    return Estudiante(
      id: id ?? this.id,
      tipoIdentificacion: tipoIdentificacion ?? this.tipoIdentificacion,
      numIdentificacion: numIdentificacion ?? this.numIdentificacion,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      genero: genero ?? this.genero,
      ocupacion: ocupacion ?? this.ocupacion,
      nivelEducacion: nivelEducacion ?? this.nivelEducacion,
      lugarEstudioTrabajo: lugarEstudioTrabajo ?? this.lugarEstudioTrabajo,
      direccion: direccion ?? this.direccion,
      correo: correo ?? this.correo,
      celular: celular ?? this.celular,
      telefono: telefono ?? this.telefono,
      establecimiento: establecimiento ?? this.establecimiento,
      programaAcademico: programaAcademico ?? this.programaAcademico,
    );
  }

}
