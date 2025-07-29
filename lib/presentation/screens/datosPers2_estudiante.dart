import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apis/presentation/widgets/campo_estandar.dart';
import 'package:apis/presentation/widgets/encabezado_formulario.dart';
import 'package:apis/presentation/widgets/boton_formulario.dart';
import 'package:apis/presentation/widgets/barra_progreso.dart';
import 'package:apis/config/helpers/alerta_emergente.dart';
import 'package:apis/presentation/providers/registro_provider.dart';

class DatosPers2EstudianteScreen extends StatefulWidget {
  const DatosPers2EstudianteScreen({super.key});

  @override
  State<DatosPers2EstudianteScreen> createState() => _DatosPers2EstudianteScreenState();
}

class _DatosPers2EstudianteScreenState extends State<DatosPers2EstudianteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ocupacion = ['Estudiante', 'Docente', 'Otro'];
  final _niveles = ['Primaria', 'Secundaria', 'Superior'];

  String? ocupacion;
  String? nivelEducacion;
  final _lugarEstudioTrabajoController = TextEditingController();

  @override
  void dispose() {
    _lugarEstudioTrabajoController.dispose();
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

                Image.asset(
                  'assets/images/imagen_margen.jpg',
                  height: 60,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8),
                const Align(
                  alignment: Alignment.center,
                  child: ProgresoRegistro(pasoActual: 2),
                ),
                const SizedBox(height: 12),

                const Icon(Icons.account_circle, size: 80, color: Color(0xFFDE0059)),
                const SizedBox(height: 6),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C2D5D),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Estudiante',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),

                const SizedBox(height: 20),
                const EncabezadoFormulario(titulo: 'Datos Personales del Estudiante'),
                const SizedBox(height: 16),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CampoEstandar(
                        label: 'Ocupación',
                        hintText: 'Seleccione su ocupación',
                        items: _ocupacion,
                        value: ocupacion,
                        onChanged: (val) => setState(() => ocupacion = val),
                      ),
                      CampoEstandar(
                        label: 'Nivel de Educación',
                        hintText: 'Seleccione el nivel',
                        items: _niveles,
                        value: nivelEducacion,
                        onChanged: (val) => setState(() => nivelEducacion = val),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            AlertaEmergente.mostrar(
                              context,
                              icono: Icons.warning_amber_rounded,
                              mensaje:
                              'Recuerde que el nivel de educación que posea influirá directamente en el programa académico que pueda seleccionar.',
                            );
                          },
                          child: const Icon(Icons.info_outline, color: Color(0xFFE51F52)),
                        ),
                      ),
                      CampoEstandar(
                        label: 'Lugar de estudio/trabajo',
                        hintText: 'Ej. Loja',
                        controller: _lugarEstudioTrabajoController,
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
                                registroProvider.actualizarDatosEstudiante({
                                  'ocupacion': ocupacion,
                                  'nivelEducacion': nivelEducacion,
                                  'lugarEstudioTrabajo': _lugarEstudioTrabajoController.text,
                                });
                                Navigator.pushNamed(context, '/contacto_estudiante');
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
