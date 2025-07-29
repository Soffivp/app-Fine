import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:apis/presentation/widgets/encabezado_formulario.dart';
import 'package:apis/presentation/widgets/barra_progreso.dart';
import 'package:apis/presentation/widgets/boton_formulario.dart';
import 'package:apis/presentation/widgets/boton_atras.dart';
import 'package:apis/presentation/widgets/campo_estandar.dart';
import 'package:apis/config/helpers/alerta_emergente.dart';
import 'package:apis/presentation/providers/registro_provider.dart';

class InfoRepresentanteScreen extends StatefulWidget {
  const InfoRepresentanteScreen({super.key});

  @override
  State<InfoRepresentanteScreen> createState() => _InfoRepresentanteScreenState();
}

class _InfoRepresentanteScreenState extends State<InfoRepresentanteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tipoIdentificacion = ['Cédula', 'Pasaporte'];
  final _estadoCivil = ['Soltero', 'Casado', 'Divorciado'];
  final _generos = ['Masculino', 'Femenino', 'Otro'];
  final _origenesIngreso = ['Empleo', 'Negocio', 'Pensión', 'Otro'];
  final _parroquias = ['El Valle', 'Sucre', 'Centro', 'Vilcabamba'];

  final TextEditingController identificacionController = TextEditingController();
  final TextEditingController nombreCompletoController = TextEditingController();

  String? tipoSeleccionado;
  String? generoSeleccionado;
  String? estadoCivilSeleccionado;
  String? origenSeleccionado;
  String? parroquiaSeleccionada;

  bool emitirFactura = false;

  @override
  void initState() {
    super.initState();
    final registroProvider = Provider.of<RegistroProvider>(context, listen: false);
    if (registroProvider.datosEstudiante['esRepresentante'] == true) {
      emitirFactura = true;
      final estudiante = registroProvider.datosEstudiante;
      tipoSeleccionado = estudiante['tipoIdentificacion'];
      identificacionController.text = estudiante['numIdentificacion'] ?? '';
      nombreCompletoController.text = '${estudiante['nombre']} ${estudiante['apellido']}';
      generoSeleccionado = estudiante['genero'];
    }
  }

  @override
  void dispose() {
    identificacionController.dispose();
    nombreCompletoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registroProvider = Provider.of<RegistroProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: BotonAtras(),
                ),
                const SizedBox(height: 12),

                Image.asset(
                  'assets/images/imagen_margen.jpg',
                  height: 60,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8),

                const ProgresoRegistro(pasoActual: 4),
                const SizedBox(height: 20),

                const Icon(Icons.account_circle, size: 80, color: Color(0xFFDE0059)),
                const SizedBox(height: 6),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C2D5D),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('Representante', style: TextStyle(color: Colors.white, fontSize: 14)),
                ),
                const SizedBox(height: 20),

                const EncabezadoFormulario(titulo: 'Datos del Representante', mostrarLogo: false),
                const SizedBox(height: 16),

                // Checkbox a la izquierda
                Row(
                  children: [
                    Checkbox(
                      value: emitirFactura,
                      onChanged: (value) {
                        setState(() {
                          emitirFactura = value ?? false;
                          if (emitirFactura) {
                            final estudiante = registroProvider.datosEstudiante;
                            tipoSeleccionado = estudiante['tipoIdentificacion'];
                            identificacionController.text = estudiante['numIdentificacion'] ?? '';
                            nombreCompletoController.text = '${estudiante['nombre']} ${estudiante['apellido']}';
                            generoSeleccionado = estudiante['genero'];
                          } else {
                            tipoSeleccionado = null;
                            identificacionController.clear();
                            nombreCompletoController.clear();
                            generoSeleccionado = null;
                          }
                        });
                      },
                      activeColor: const Color(0xFF213354),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Emitir factura a nombre del estudiante',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CampoEstandar(
                        label: 'Tipo de Identificación',
                        hintText: 'Seleccione un tipo',
                        items: _tipoIdentificacion,
                        value: tipoSeleccionado,
                        onChanged: (val) => setState(() => tipoSeleccionado = val),
                      ),
                      CampoEstandar(
                        label: 'Número de Identificación',
                        hintText: 'Ingrese el número',
                        controller: identificacionController,
                        keyboardType: TextInputType.number,
                      ),
                      CampoEstandar(
                        label: 'Razón Social / Nombre Completo',
                        hintText: 'Ingrese nombre completo',
                        controller: nombreCompletoController,
                      ),
                      CampoEstandar(
                        label: 'Origen de Ingresos',
                        hintText: 'Seleccione un origen',
                        items: _origenesIngreso,
                        value: origenSeleccionado,
                        onChanged: (val) => setState(() => origenSeleccionado = val),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            AlertaEmergente.mostrar(
                              context,
                              icono: Icons.info,
                              mensaje: 'Incluya el origen principal de los ingresos del representante.',
                            );
                          },
                          child: const Icon(Icons.info, color: Color(0xFFE51F52)),
                        ),
                      ),
                      CampoEstandar(
                        label: 'Parroquia',
                        hintText: 'Seleccione parroquia',
                        items: _parroquias,
                        value: parroquiaSeleccionada,
                        onChanged: (val) => setState(() => parroquiaSeleccionada = val),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            AlertaEmergente.mostrar(
                              context,
                              icono: Icons.info,
                              mensaje: 'Indique la parroquia de residencia del representante.',
                            );
                          },
                          child: const Icon(Icons.info, color: Color(0xFFE51F52)),
                        ),
                      ),
                      CampoEstandar(
                        label: 'Estado Civil',
                        hintText: 'Seleccione una opción',
                        items: _estadoCivil,
                        value: estadoCivilSeleccionado,
                        onChanged: (val) => setState(() => estadoCivilSeleccionado = val),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            AlertaEmergente.mostrar(
                              context,
                              icono: Icons.info,
                              mensaje: 'Este dato es requerido por fines administrativos.',
                            );
                          },
                          child: const Icon(Icons.info, color: Color(0xFFE51F52)),
                        ),
                      ),
                      CampoEstandar(
                        label: 'Género',
                        hintText: 'Seleccione género',
                        items: _generos,
                        value: generoSeleccionado,
                        onChanged: (val) => setState(() => generoSeleccionado = val),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            AlertaEmergente.mostrar(
                              context,
                              icono: Icons.info,
                              mensaje: 'Seleccionar el género ayuda a estadísticas del sistema.',
                            );
                          },
                          child: const Icon(Icons.info, color: Color(0xFFE51F52)),
                        ),
                      ),

                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BotonFormulario(
                            texto: 'Siguiente',
                            color: Colors.white,
                            textoColor: Colors.black,
                            bordeColor: Colors.black,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                registroProvider.actualizarDatosRepresentante({
                                  'emitirFacturaAlEstudiante': emitirFactura,
                                  'tipoIdentificacion': tipoSeleccionado,
                                  'numeroIdentificacion': identificacionController.text,
                                  'razonSocial/NombreCompleto': nombreCompletoController.text,
                                  'origenIngresos': origenSeleccionado,
                                  'parroquia': parroquiaSeleccionada,
                                  'estadoCivil': estadoCivilSeleccionado,
                                  'genero': generoSeleccionado,
                                });
                                Navigator.pushNamed(context, '/contacto_representante');
                              }
                            },
                            habilitado: true,
                          ),
                          const SizedBox(width: 12),
                          BotonFormulario(
                            texto: 'Cancelar',
                            color: const Color(0xFFE51F52),
                            textoColor: Colors.white,
                            bordeColor: const Color(0xFFE51F52),
                            onPressed: () => Navigator.pop(context),
                            habilitado: true,
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
      ),
    );
  }
}
