import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apis/presentation/widgets/campo_estandar.dart';
import 'package:apis/presentation/widgets/campo_fecha.dart';
import 'package:apis/presentation/widgets/boton_formulario.dart';
import 'package:apis/presentation/widgets/encabezado_formulario.dart';
import 'package:apis/presentation/widgets/barra_progreso.dart';
import 'package:apis/config/helpers/validadores.dart';
import 'package:apis/presentation/providers/registro_provider.dart';

class DatosPersEstudiantesScreen extends StatefulWidget {
  const DatosPersEstudiantesScreen({super.key});

  @override
  State<DatosPersEstudiantesScreen> createState() =>
      _DatosPersEstudiantesScreenState();
}

class _DatosPersEstudiantesScreenState
    extends State<DatosPersEstudiantesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController fechaNacimientoController =
  TextEditingController();

  String? _tipoIdentificacion;
  String? _genero;
  DateTime? _fechaNacimiento;

  @override
  Widget build(BuildContext context) {
    final registroProvider = Provider.of<RegistroProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Botón de retroceso dentro de una cajita
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDEDED),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 2,
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back, size: 20),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Logo
              Image.asset(
                'assets/images/imagen_margen.jpg',
                width: 180,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 12),

              // Barra de progreso centrada
              const Align(
                alignment: Alignment.center,
                child: ProgresoRegistro(pasoActual: 1),
              ),

              const SizedBox(height: 16),
              const Icon(Icons.account_circle,
                  size: 80, color: Color(0xFFDE0059)),
              const SizedBox(height: 6),

              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C2C4C),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Estudiante',
                    style: TextStyle(color: Colors.white)),
              ),

              const SizedBox(height: 16),
              const EncabezadoFormulario(titulo: 'Datos Personales del Estudiante'),

              const SizedBox(height: 20),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CampoEstandar(
                      label: 'Tipo de Identificación',
                      hintText: 'Seleccione un tipo',
                      items: const ['Cédula', 'Pasaporte', 'RUC', 'Extranjero'],
                      value: _tipoIdentificacion,
                      onChanged: (value) =>
                          setState(() => _tipoIdentificacion = value),
                      validator: (value) =>
                      value == null ? 'Seleccione un tipo' : null,
                    ),
                    CampoEstandar(
                      label: 'Número de identificación',
                      hintText: 'Ingrese su número',
                      controller: _cedulaController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (_tipoIdentificacion == 'Cédula') {
                          return Validators.validarCedula(value);
                        } else if (_tipoIdentificacion == 'RUC') {
                          return Validators.validarRUC(value);
                        } else {
                          return 'Seleccione un tipo de identificación';
                        }
                      },
                    ),
                    CampoEstandar(
                      label: 'Nombre/s',
                      hintText: 'Ingrese sus nombres',
                      controller: _nombresController,
                      validator: (value) =>
                          Validators.validarTexto(value, campo: 'Nombre'),
                    ),
                    CampoEstandar(
                      label: 'Apellido/s',
                      hintText: 'Ingrese sus apellidos',
                      controller: _apellidosController,
                      validator: (value) =>
                          Validators.validarTexto(value, campo: 'Apellido'),
                    ),
                    CampoFecha(
                      label: 'Fecha de Nacimiento',
                      hintText: 'Seleccione la fecha',
                      controller: fechaNacimientoController,
                      initialDate: _fechaNacimiento,
                      onDateSelected: (value) {
                        setState(() {
                          _fechaNacimiento = value;
                        });
                      },
                    ),
                    CampoEstandar(
                      label: 'Género',
                      hintText: 'Seleccione género',
                      items: const ['Masculino', 'Femenino'],
                      value: _genero,
                      onChanged: (value) => setState(() => _genero = value),
                      validator: (value) =>
                      value == null ? 'Seleccione un género' : null,
                    ),
                    const SizedBox(height: 24),

                    // Botones centrados y juntos
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BotonFormulario(
                          texto: 'Siguiente',
                          color: Colors.white,
                          textoColor: const Color(0xFF1C2C4C),
                          bordeColor: const Color(0xFF1C2C4C),
                          habilitado: true,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              registroProvider.actualizarDatosEstudiante({
                                'tipoIdentificacion': _tipoIdentificacion,
                                'numIdentificacion': _cedulaController.text,
                                'nombre': _nombresController.text,
                                'apellido': _apellidosController.text,
                                'fechaNacimiento': _fechaNacimiento,
                                'genero': _genero,
                              });
                              Navigator.pushNamed(
                                  context, '/datosPers2_estudiante');
                            }
                          },
                        ),
                        const SizedBox(width: 12),
                        BotonFormulario(
                          texto: 'Cancelar',
                          color: const Color(0xFFDE0059),
                          textoColor: Colors.white,
                          bordeColor: const Color(0xFFDE0059),
                          habilitado: true,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
