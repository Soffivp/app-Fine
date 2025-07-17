import 'package:flutter/material.dart';
import 'matricul.dart'; // Asegúrate de que este archivo exista y contenga la clase MatricularEstudianteForm

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
// Elimina esta línea, es incorrecta:
// @override
// MatricularEstudianteForm createState() => _MatricularEstudianteFormState();
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

  void _iniciarSesion() {
    if (_formKey.currentState!.validate()) {
      final usuario = _usuarioController.text;
      final contrasena = _contrasenaController.text;

      if (usuario == 'user' && contrasena == '123') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Inicio de sesión exitoso')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => IngresarDatos()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario o contraseña incorrectos')),
        );
      }
    }
  }

  // Método para abrir el formulario de matrícula
  void _abrirFormularioMatricula() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MatricularEstudianteForm(), // Usa la clase Widget, no el State
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
                // Logo
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

                // Título
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

                // Campo de Usuario
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
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
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

                // Campo de Contraseña
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
                                _mostrarContrasena
                                    ? Icons.visibility
                                    : Icons.visibility_off,
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
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
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

                // Checkbox Recordarme
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

                // Olvidé mi contraseña
                Positioned(
                  left: 179,
                  top: 492,
                  child: TextButton(
                    onPressed: () {
                      // Acción para recuperar contraseña
                    },
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

                // Botones
                Positioned(
                  left: 60,
                  top: 547,
                  child: Container(
                    width: 240,
                    child: Row(
                      children: [
                        // Botón Matricular
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF213354),
                              padding: EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: _abrirFormularioMatricula, // Usa el método corregido
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

                        // Botón Ingresar
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

class IngresarDatos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingresar Datos'),
      ),
      body: Center(
        child: Text('Pantalla de Ingreso de Datos'),
      ),
    );
  }
}