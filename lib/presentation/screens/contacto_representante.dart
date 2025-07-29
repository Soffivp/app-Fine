import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:apis/presentation/widgets/campo_estandar.dart';
import 'package:apis/presentation/widgets/boton_formulario.dart';
import 'package:apis/presentation/widgets/encabezado_formulario.dart';
import 'package:apis/presentation/widgets/barra_progreso.dart';
import 'package:apis/presentation/widgets/boton_atras.dart';
import 'package:apis/config/helpers/alerta_emergente.dart';
import 'package:apis/presentation/providers/registro_provider.dart';

class ContactoRepresentanteScreen extends StatefulWidget {
  const ContactoRepresentanteScreen({super.key});

  @override
  State<ContactoRepresentanteScreen> createState() => _ContactoRepresentanteScreenState();
}

class _ContactoRepresentanteScreenState extends State<ContactoRepresentanteScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();

  bool _datosAutocompletados = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final registroProvider = Provider.of<RegistroProvider>(context, listen: false);
    final esRepresentante = registroProvider.datosEstudiante['esRepresentante'] ?? false;
    final emitirFactura = registroProvider.datosRepresentante['emitirFacturaAlEstudiante'] ?? false;

    if ((esRepresentante || emitirFactura) && !_datosAutocompletados) {
      final datos = registroProvider.datosEstudiante;
      _direccionController.text = datos['direccion'] ?? '';
      _correoController.text = datos['correo'] ?? '';
      _celularController.text = datos['celular'] ?? '';
      _telefonoController.text = datos['telefono'] ?? '';
      _datosAutocompletados = true;
    }
  }

  @override
  void dispose() {
    _direccionController.dispose();
    _correoController.dispose();
    _celularController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  void _mostrarAlerta() {
    AlertaEmergente.mostrar(
      context,
      icono: Icons.priority_high,
      mensaje: 'El representante es la persona natural o jurídica a cuyo nombre se le emitirán tanto facturas como notificaciones académicas.',
    );
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
            child: Form(
              key: _formKey,
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

                  const ProgresoRegistro(pasoActual: 6),
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
                      'Representante',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Datos de contacto del representante',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF3C578A),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.error_outline, color: Colors.red),
                        onPressed: _mostrarAlerta,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  CampoEstandar(
                    label: 'Dirección',
                    hintText: 'Ingrese dirección',
                    controller: _direccionController,
                    validator: (val) => val == null || val.isEmpty ? 'Campo obligatorio' : null,
                  ),
                  CampoEstandar(
                    label: 'Email',
                    hintText: 'Ingrese correo electrónico',
                    controller: _correoController,
                    validator: (val) => val == null || val.isEmpty ? 'Campo obligatorio' : null,
                  ),
                  CampoEstandar(
                    label: 'Celular (Grupo WhatsApp)',
                    hintText: 'Ingrese número celular',
                    controller: _celularController,
                    validator: (val) => val == null || val.isEmpty ? 'Campo obligatorio' : null,
                  ),
                  CampoEstandar(
                    label: 'Teléfono',
                    hintText: 'Ingrese número convencional',
                    controller: _telefonoController,
                    validator: (val) => null, // ahora es opcional
                  ),
                  const SizedBox(height: 24),

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
                          if (_formKey.currentState!.validate()) {
                            registroProvider.actualizarDatosRepresentante({
                              'direccion': _direccionController.text,
                              'correo': _correoController.text,
                              'celular': _celularController.text,
                              'telefono': _telefonoController.text,
                            });
                            Navigator.pushNamed(context, '/crear_usuario');
                          }
                        },
                      ),
                      const SizedBox(width: 12),
                      BotonFormulario(
                        texto: 'Cancelar',
                        color: const Color(0xFFE51F52),
                        textoColor: Colors.white,
                        bordeColor: Colors.transparent,
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
      ),
    );
  }
}
