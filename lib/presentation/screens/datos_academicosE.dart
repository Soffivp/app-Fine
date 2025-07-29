import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:apis/presentation/widgets/encabezado_formulario.dart';
import 'package:apis/presentation/widgets/barra_progreso.dart';
import 'package:apis/presentation/widgets/boton_formulario.dart';
import 'package:apis/presentation/widgets/boton_atras.dart';
import 'package:apis/presentation/widgets/campo_estandar.dart';
import 'package:apis/presentation/providers/registro_provider.dart';

class DatosAcademicosEstudianteScreen extends StatefulWidget {
  const DatosAcademicosEstudianteScreen({super.key});

  @override
  State<DatosAcademicosEstudianteScreen> createState() => _DatosAcademicosEstudianteScreenState();
}

class _DatosAcademicosEstudianteScreenState extends State<DatosAcademicosEstudianteScreen> {
  String? _establecimiento;
  String? _programaSeleccionado;

  final List<String> establecimientos = ['Loja', 'Zamora', 'Yantzaza'];
  final List<String> programas = ['ENGLISH EXPRESS', 'ENGLISH KIDS', 'TEENS ADVANCED'];

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
                  child: const Text(
                    'Estudiante',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 20),

                const EncabezadoFormulario(titulo: 'Datos académicos', mostrarLogo: false),
                const SizedBox(height: 20),

                CampoEstandar(
                  label: 'Establecimiento',
                  hintText: 'Seleccione un establecimiento',
                  items: establecimientos,
                  value: _establecimiento,
                  onChanged: (val) => setState(() => _establecimiento = val),
                ),
                CampoEstandar(
                  label: 'Programa académico',
                  hintText: 'Seleccione un programa',
                  items: programas,
                  value: _programaSeleccionado,
                  onChanged: (val) => setState(() => _programaSeleccionado = val),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BotonFormulario(
                      texto: 'Siguiente',
                      color: Colors.white,
                      textoColor: const Color(0xFF213354),
                      bordeColor: const Color(0xFF213354),
                      habilitado: true,
                      onPressed: () {
                        if (_establecimiento != null && _programaSeleccionado != null) {
                          registroProvider.actualizarDatosEstudiante({
                            'establecimiento': _establecimiento!,
                            'programaAcademico': _programaSeleccionado!,
                          });
                          Navigator.pushNamed(context, '/info_representante');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Por favor selecciona establecimiento y programa.')),
                          );
                        }
                      },
                    ),
                    const SizedBox(width: 12),
                    BotonFormulario(
                      texto: 'Cancelar',
                      color: const Color(0xFFE51F52),
                      textoColor: Colors.white,
                      bordeColor: const Color(0xFFE51F52),
                      habilitado: true,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
