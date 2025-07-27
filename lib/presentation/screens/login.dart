import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'matricul.dart';
import 'package:apis/presentation/screens/matricul1.dart';
import 'package:apis/presentation/screens/home_F.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
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
      final usuarioIngresado = _usuarioController.text.trim();
      final contrasenaIngresada = _contrasenaController.text.trim();

      try {
        final estudiantesSnapshot = await FirebaseFirestore.instance.collection('estudiantes').get();
        bool credencialValida = false;

        for (var estudiante in estudiantesSnapshot.docs) {
          final credencialesSnapshot = await estudiante.reference.collection('credenciales').get();

          for (var credencial in credencialesSnapshot.docs) {
            final data = credencial.data();
            if (data['usuario'] == usuarioIngresado && data['contrasena'] == contrasenaIngresada) {
              credencialValida = true;
              break;
            }
          }

          if (credencialValida) break;
        }

        if (credencialValida) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Inicio de sesión exitoso')),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuario o contraseña incorrectos')),
          );
        }
      } catch (e) {
        print('Error al verificar credenciales: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al conectar con la base de datos')),
        );
      }
    }
  }

  void _abrirFormularioMatricula() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MatricularEstudianteForm1(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 360,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Positioned(
                  left: 113,
                  top: 145,
                  child: Container(
                    width: 133.96,
                    height: 117,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://placehold.co/134x117"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 35,
                  top: 261,
                  child: Container(
                    width: 292.84,
                    height: 51,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://placehold.co/293x51"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 40,
                  top: 330,
                  child: Container(
                    width: 280,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Usuario',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _usuarioController,
                          decoration: InputDecoration(
                            hintText: 'Ingrese su usuario',
                            hintStyle: TextStyle(
                              color: Color(0xFFA2A1A1),
                              fontSize: 13,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese su usuario';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 40,
                  top: 409,
                  child: Container(
                    width: 280,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contraseña',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _contrasenaController,
                          obscureText: !_mostrarContrasena,
                          decoration: InputDecoration(
                            hintText: 'Ingrese su contraseña',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _mostrarContrasena ? Icons.visibility : Icons.visibility_off,
                                size: 18,
                              ),
                              onPressed: () {
                                setState(() {
                                  _mostrarContrasena = !_mostrarContrasena;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFFD9D9D9),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese su contraseña';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 44,
                  top: 488,
                  child: Row(
                    children: [
                      Checkbox(
                        value: _recordarme,
                        onChanged: (value) {
                          setState(() {
                            _recordarme = value ?? false;
                          });
                        },
                        activeColor: Color(0xFFE51F52),
                      ),
                      Text(
                        'Recordarme',
                        style: TextStyle(
                          color: Color(0xFF213354),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 179,
                  top: 492,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Olvidé mi contraseña »',
                      style: TextStyle(
                        color: Color(0xFF186BDF),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 60,
                  top: 547,
                  child: Container(
                    width: 240,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF213354),
                              padding: EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: _abrirFormularioMatricula,
                            child: Text(
                              'Matricular',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFE51F52),
                              padding: EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: _iniciarSesion,
                            child: Text(
                              'Ingresar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
