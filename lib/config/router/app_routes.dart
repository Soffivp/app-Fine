import 'package:flutter/material.dart';
import 'package:apis/presentation/screens/login.dart';
import 'package:apis/presentation/screens/datosPers_Estudiantes.dart';
import 'package:apis/presentation/screens/datosPers2_estudiante.dart';
import 'package:apis/presentation/screens/contacto_estudiante.dart';
import 'package:apis/presentation/screens/datos_academicosE.dart';
import 'package:apis/presentation/screens/info_represent.dart';
import 'package:apis/presentation/screens/contacto_representante.dart';
import 'package:apis/presentation/screens/crear_credenciales.dart';
import 'package:apis/presentation/screens/terminos_condiciones.dart';
import 'package:apis/presentation/screens/login.dart';
import 'package:apis/presentation/screens/home_F.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
    '/login': (_) => Login(),
    '/datos_estudiante': (_) => const DatosPersEstudiantesScreen(),
    '/datosPers2_estudiante': (_) => const DatosPers2EstudianteScreen(),
    '/contacto_estudiante': (_) => const ContactoEstudianteScreen(),
    '/datos_academicos_estudiante': (_) => const DatosAcademicosEstudianteScreen(),
    '/info_representante': (_) => const InfoRepresentanteScreen(),
    '/contacto_representante': (_) => const ContactoRepresentanteScreen(),
    '/crear_usuario': (_) => const CrearCredencialesScreen(),
    '/terminos_condiciones': (_) => const TerminosCondicionesScreen(),
    '/login': (_) => Login(),
    '/home': (context) => HomeScreen(),

  };
}
