import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:apis/presentation/providers/registro_provider.dart';
import 'package:apis/presentation/widgets/boton_formulario.dart';
import 'package:apis/presentation/widgets/campo_estandar.dart';
import 'package:apis/presentation/widgets/encabezado_formulario.dart';
import 'package:apis/presentation/widgets/barra_progreso.dart';
import 'package:apis/presentation/widgets/boton_atras.dart';

class CrearCredencialesScreen extends StatefulWidget {
  const CrearCredencialesScreen({super.key});

  @override
  State<CrearCredencialesScreen> createState() => _CrearCredencialesScreenState();
}

class _CrearCredencialesScreenState extends State<CrearCredencialesScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final TextEditingController _confirmarController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final datosEstudiante = Provider.of<RegistroProvider>(context, listen: false).datosEstudiante;
    if (_usuarioController.text.isEmpty) {
      _usuarioController.text = datosEstudiante['cedula'] ?? '';
    }
  }

  @override
  void dispose() {
    _usuarioController.dispose();
    _contrasenaController.dispose();
    _confirmarController.dispose();
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
                const Align(alignment: Alignment.topLeft, child: BotonAtras()),
                const SizedBox(height: 12),

                Image.asset('assets/images/imagen_margen.jpg', height: 60),
                const SizedBox(height: 8),

                const ProgresoRegistro(pasoActual: 7),
                const SizedBox(height: 16),

                const Icon(Icons.account_circle, size: 80, color: Color(0xFFDE0059)),
                const SizedBox(height: 6),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C2D5D),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('Crear Usuario', style: TextStyle(color: Colors.white, fontSize: 14)),
                ),

                const SizedBox(height: 20),
                const EncabezadoFormulario(titulo: 'Ingrese sus credenciales de acceso'),
                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3C578A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline, color: Colors.white),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Le recomendamos que su nombre de usuario sea la cédula. Recuerde que los nombres de usuario son únicos',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CampoEstandar(
                        label: 'Nombre de usuario',
                        hintText: 'Ingrese nombre de usuario',
                        controller: _usuarioController,
                        validator: (val) => val == null || val.trim().isEmpty ? 'Campo obligatorio' : null,
                        habilitado: true,
                        onChanged: (value) {
                          registroProvider.actualizarCredenciales({
                            'usuario': value,
                            'contrasena': _contrasenaController.text,
                          });
                        },
                      ),
                      const SizedBox(height: 10),

                      CampoEstandar(
                        label: 'Contraseña',
                        hintText: 'Ingrese una contraseña',
                        controller: _contrasenaController,
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                        validator: (val) =>
                        val == null || val.length < 6 ? 'Mínimo 6 caracteres' : null,
                        onChanged: (value) {
                          registroProvider.actualizarCredenciales({
                            'usuario': _usuarioController.text,
                            'contrasena': value,
                          });
                        },
                      ),
                      const SizedBox(height: 10),

                      CampoEstandar(
                        label: 'Confirmar Contraseña',
                        hintText: 'Repita la contraseña',
                        controller: _confirmarController,
                        obscureText: _obscureConfirm,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                        ),
                        validator: (val) =>
                        val != _contrasenaController.text ? 'Las contraseñas no coinciden' : null,
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
                                registroProvider.actualizarCredenciales({
                                  'usuario': _usuarioController.text,
                                  'contrasena': _contrasenaController.text,
                                });
                                Navigator.pushNamed(context, '/terminos_condiciones');
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
