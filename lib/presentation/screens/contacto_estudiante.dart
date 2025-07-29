import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apis/presentation/widgets/campo_estandar.dart';
import 'package:apis/presentation/widgets/boton_formulario.dart';
import 'package:apis/presentation/widgets/encabezado_formulario.dart';
import 'package:apis/presentation/widgets/barra_progreso.dart';
import 'package:apis/presentation/widgets/boton_atras.dart';
import 'package:apis/presentation/providers/registro_provider.dart';
import 'package:apis/config/helpers/validadores.dart';

class ContactoEstudianteScreen extends StatefulWidget {
  const ContactoEstudianteScreen({super.key});

  @override
  State<ContactoEstudianteScreen> createState() =>
      _ContactoEstudianteScreenState();
}

class _ContactoEstudianteScreenState extends State<ContactoEstudianteScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();

  @override
  void dispose() {
    _direccionController.dispose();
    _emailController.dispose();
    _celularController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registroProvider =
    Provider.of<RegistroProvider>(context, listen: false);

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
                  alignment: Alignment.topLeft,
                  child: BotonAtras(),
                ),
                const SizedBox(height: 12),

                // Logo
                Image.asset(
                  'assets/images/imagen_margen.jpg',
                  height: 60,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8),

                const ProgresoRegistro(pasoActual: 3),
                const SizedBox(height: 16),

                // Ícono de usuario rosado
                const Icon(Icons.account_circle,
                    size: 80, color: Color(0xFFDE0059)),
                const SizedBox(height: 6),

                // Etiqueta Estudiante
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                const EncabezadoFormulario(
                    titulo: 'Datos de contacto del estudiante'),
                const SizedBox(height: 16),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CampoEstandar(
                        label: 'Dirección',
                        hintText: 'Ingrese su dirección de domicilio / barrio',
                        controller: _direccionController,
                        validator: (value) =>
                            Validators.validarTexto(value, campo: 'Dirección'),
                      ),
                      CampoEstandar(
                        label: 'Email',
                        hintText: 'Ingrese su correo electrónico',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validarCorreo,
                      ),
                      CampoEstandar(
                        label: 'Celular',
                        hintText: 'Ingrese su número celular',
                        controller: _celularController,
                        keyboardType: TextInputType.phone,
                        validator: Validators.validarCelular,
                      ),
                      CampoEstandar(
                        label: 'Teléfono',
                        hintText: 'Ingrese su número de teléfono convencional',
                        controller: _telefonoController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return null; // permite vacío
                          return Validators.validarTelefono(value); // valida solo si se ingresó algo
                        },
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
                            habilitado: true,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                registroProvider.actualizarDatosEstudiante({
                                  'direccion': _direccionController.text,
                                  'correo': _emailController.text,
                                  'celular': _celularController.text,
                                  'telefono': _telefonoController.text,
                                });
                                Navigator.pushNamed(
                                    context, '/datos_academicos_estudiante');
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
