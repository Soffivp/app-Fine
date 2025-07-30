import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:apis/presentation/widgets/campo_estandar.dart';
import 'package:apis/presentation/widgets/boton_formulario.dart';
import 'package:apis/presentation/screens/home_F.dart';
import 'package:apis/presentation/screens/datosPers_Estudiantes.dart';
import 'package:apis/presentation/providers/estudiante_provider.dart';
import 'package:apis/domain/entities/estudiante.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  bool _recordarme = false;
  bool _mostrarContrasena = false;

  @override
  void dispose() {
    _usuarioController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  Future<void> _iniciarSesion() async {
    if (_formKey.currentState!.validate()) {
      final usuario = _usuarioController.text.trim();
      final email = '$usuario@fineapp.com'; // 👈 Convertimos el usuario en correo válido
      final password = _contrasenaController.text.trim();

      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        final uid = credential.user?.uid;
        if (uid == null) throw Exception("No se pudo obtener el UID del usuario");

        final doc = await FirebaseFirestore.instance
            .collection('estudiantes')
            .doc(uid)
            .get();

        if (!doc.exists) {
          throw Exception("Estudiante no encontrado en la base de datos");
        }

        final datosEstudiante = doc.data()!;
        datosEstudiante['id'] = doc.id;

        final estudiante = Estudiante.fromJson(datosEstudiante);
        final estudianteProvider = context.read<EstudianteProvider>();
        estudianteProvider.setEstudiante(estudiante);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inicio de sesión exitoso')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } on FirebaseAuthException catch (e) {
        String mensaje = "Error al iniciar sesión";
        if (e.code == 'user-not-found') mensaje = "Usuario no registrado";
        if (e.code == 'wrong-password') mensaje = "Contraseña incorrecta";

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mensaje)),
        );
      } catch (e) {
        print("❌ Error general en login: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ocurrió un error al iniciar sesión")),
        );
      }
    }
  }

  void _abrirFormularioMatricula() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const DatosPersEstudiantesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo centrado
                Center(
                  child: Image.asset(
                    'assets/images/logoCompleto.png',
                    height: 120,
                  ),
                ),
                const SizedBox(height: 32),

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CampoEstandar(
                        label: 'Usuario',
                        hintText: 'Ingrese su usuario',
                        controller: _usuarioController,
                        validator: (val) =>
                        val == null || val.isEmpty ? 'Campo obligatorio' : null,
                        habilitado: true,
                      ),
                      const SizedBox(height: 20),

                      CampoEstandar(
                        label: 'Contraseña',
                        hintText: 'Ingrese su contraseña',
                        controller: _contrasenaController,
                        obscureText: !_mostrarContrasena,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _mostrarContrasena ? Icons.visibility : Icons.visibility_off,
                            color: Colors.pink,
                          ),
                          onPressed: () {
                            setState(() {
                              _mostrarContrasena = !_mostrarContrasena;
                            });
                          },
                        ),
                        validator: (val) =>
                        val == null || val.isEmpty ? 'Campo obligatorio' : null,
                        habilitado: true,
                      ),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Checkbox(
                            value: _recordarme,
                            onChanged: (val) => setState(() {
                              _recordarme = val ?? false;
                            }),
                            activeColor: const Color(0xFFE51F52),
                          ),
                          const Text(
                            'Recordarme',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF213354),
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              // lógica para recuperar contraseña
                            },
                            child: const Text(
                              'Olvidé mi contraseña »',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF186BDF),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BotonFormulario(
                            texto: 'Matricular',
                            color: const Color(0xFF213354),
                            textoColor: Colors.white,
                            bordeColor: Colors.transparent,
                            onPressed: _abrirFormularioMatricula,
                            habilitado: true,
                          ),
                          const SizedBox(width: 16),
                          BotonFormulario(
                            texto: 'Ingresar',
                            color: const Color(0xFFE51F52),
                            textoColor: Colors.white,
                            bordeColor: Colors.transparent,
                            onPressed: _iniciarSesion,
                            habilitado: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
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
