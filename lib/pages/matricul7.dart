import 'package:flutter/material.dart';

class MatricularmeEstudiante7 extends StatefulWidget {
  @override
  _MatricularmeEstudiante7State createState() => _MatricularmeEstudiante7State();
}

class _MatricularmeEstudiante7State extends State<MatricularmeEstudiante7> {
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: 360,
                height: 785,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Colors.white),
                child: Stack(
                  children: [
                    Positioned(
                      left: 38,
                      top: 273,
                      child: Text(
                        'Datos de contacto del estudiante',
                        style: TextStyle(
                          color: const Color(0xFF3C578A),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                    ),

                    _buildTextField(
                      left: 38,
                      top: 323,
                      label: 'Dirección',
                      hintText: 'Ingrese su dirección',
                      controller: _direccionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su dirección';
                        }
                        return null;
                      },
                    ),

                    _buildTextField(
                      left: 39,
                      top: 403,
                      label: 'Email',
                      hintText: 'Ingrese su email',
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su email';
                        }
                        if (!value.contains('@')) {
                          return 'Ingrese un email válido';
                        }
                        return null;
                      },
                    ),

                    _buildTextField(
                      left: 38,
                      top: 483,
                      label: 'Celular',
                      hintText: 'Ingrese su número de celular',
                      controller: _celularController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su celular';
                        }
                        if (value.length < 10) {
                          return 'El celular debe tener al menos 10 dígitos';
                        }
                        return null;
                      },
                    ),

                    _buildTextField(
                      left: 38,
                      top: 563,
                      label: 'Teléfono',
                      hintText: 'Ingrese su número de teléfono',
                      controller: _telefonoController,
                      keyboardType: TextInputType.phone,
                    ),

                    Positioned(
                      left: 60,
                      top: 662,
                      child: Container(
                        width: 240,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 16,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF213354),
                                  side: BorderSide(
                                    width: 1,
                                    color: const Color(0xFF213354),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.all(12),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _procesarFormulario();
                                  }
                                },
                                child: Text(
                                  'Siguiente',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE51F52),
                                  foregroundColor: const Color(0xFFF5F5F5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.all(12),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      left: 38,
                      top: 57,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF5F5F5),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: const Color(0xFFD9D9D9),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),

                    Positioned(
                      left: 121.42,
                      top: 55,
                      child: Container(
                        width: 200.97,
                        height: 35,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("https://placehold.co/201x35"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: 78.42,
                      top: 55,
                      child: Container(
                        width: 42.50,
                        height: 35,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("https://placehold.co/42x35"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: 147,
                      top: 156,
                      child: Container(
                        width: 66,
                        height: 66,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: OvalBorder(),
                        ),
                      ),
                    ),

                    Positioned(
                      left: 130,
                      top: 231,
                      child: Container(
                        width: 100,
                        height: 28,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF213354),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Center(
                          child: Text(
                            'Estudiante',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 1.20,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: 150,
                      top: 161,
                      child: Container(
                        width: 60,
                        height: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFE51F52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    Positioned(
                      left: 38,
                      top: 101,
                      child: Container(
                        width: 284,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 13,
                          children: [
                            Container(
                              width: 294,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(4, (index) {
                                  bool isActive = index < 3;
                                  return Row(
                                    children: [
                                      Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          color: isActive ? const Color(
                                              0xFFE51F52) : const Color(
                                              0xFF666666),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: 11,
                                            height: 11,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Container(
                                                width: 7,
                                                height: 7,
                                                decoration: BoxDecoration(
                                                  color: isActive ? const Color(
                                                      0xFFE51F52) : const Color(
                                                      0xFF666666),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (index < 3)
                                        Container(
                                          width: 14,
                                          height: 1,
                                          color: const Color(0xFFE51F52),
                                        ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required double left,
    required double top,
    required String label,
    required String hintText,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: 284,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: const Color(0xFF213354),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.40,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: const Color(0xFFA2A1A1),
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.40,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 1,
                    color: const Color(0xFFD9D9D9),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
              ),
              validator: validator,
            ),
          ],
        ),
      ),
    );
  }


  void _procesarFormulario() {
    final datos = {
      'direccion': _direccionController.text,
      'email': _emailController.text,
      'celular': _celularController.text,
      'telefono': _telefonoController.text,
    };

    print('Datos del formulario: $datos');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Formulario enviado correctamente')),
    );

    // Aquí podrías navegar a otra pantalla si es necesario
    // Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaFinal()));
  }
}