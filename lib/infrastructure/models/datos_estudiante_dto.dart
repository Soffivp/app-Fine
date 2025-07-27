import 'package:apis/domain/entities/datos_estudiantes.dart';

class DatosEstudianteDto {
  final String nombre;
  final String apellido;
  final String cedula;
  final String telefono;
  final String correo;

  DatosEstudianteDto({
    required this.nombre,
    required this.apellido,
    required this.cedula,
    required this.telefono,
    required this.correo,
  });

  factory DatosEstudianteDto.fromEntity(DatosEstudiante e) {
    return DatosEstudianteDto(
      nombre: e.nombre,
      apellido: e.apellido,
      cedula: e.cedula,
      telefono: e.telefono,
      correo: e.correo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'cedula': cedula,
      'telefono': telefono,
      'correo': correo,
    };
  }
}
