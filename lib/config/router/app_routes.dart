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
import 'package:apis/presentation/screens/home_F.dart';
import 'package:apis/presentation/screens/seccion_matricula.dart';
import 'package:apis/presentation/screens/pagar_matricula.dart';
import 'package:apis/presentation/screens/deposito_matricula.dart';

class AppRoutes {
  static const login = '/login';
  static const datosEstudiante = '/datos_estudiante';
  static const datosPers2Estudiante = '/datosPers2_estudiante';
  static const contactoEstudiante = '/contacto_estudiante';
  static const datosAcademicosEstudiante = '/datos_academicos_estudiante';
  static const infoRepresentante = '/info_representante';
  static const contactoRepresentante = '/contacto_representante';
  static const crearUsuario = '/crear_usuario';
  static const terminosCondiciones = '/terminos_condiciones';
  static const home = '/home';
  static const matricularse = '/matricularse';
  static const pagoMatricula = '/pago-matricula';
  static const depositoMatricula = '/deposito-matricula'; // ✅ constante agregada

  static Map<String, WidgetBuilder> get routes => {
    login: (_) => Login(),
    datosEstudiante: (_) => const DatosPersEstudiantesScreen(),
    datosPers2Estudiante: (_) => const DatosPers2EstudianteScreen(),
    contactoEstudiante: (_) => const ContactoEstudianteScreen(),
    datosAcademicosEstudiante: (_) => const DatosAcademicosEstudianteScreen(),
    infoRepresentante: (_) => const InfoRepresentanteScreen(),
    contactoRepresentante: (_) => const ContactoRepresentanteScreen(),
    crearUsuario: (_) => const CrearCredencialesScreen(),
    terminosCondiciones: (_) => const TerminosCondicionesScreen(),
    home: (_) => HomeScreen(),
    matricularse: (_) => const SeccionMatriculaScreen(),
    pagoMatricula: (_) => const PagoMatriculaScreen(),
    depositoMatricula: (_) => const DepositoMatriculaScreen(), // ✅ ruta asignada correctamente
  };
}
