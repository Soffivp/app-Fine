import 'package:flutter/material.dart';
import 'package:apis/presentation/screens/crear_usuario.dart';
import 'package:apis/presentation/screens/datos_academicosE.dart';

class MatricularmeEstudiante7 extends StatefulWidget {
  const MatricularmeEstudiante7({Key? key}) : super(key: key);

  @override
  _MatricularmeEstudiante7State createState() => _MatricularmeEstudiante7State();
}

class _MatricularmeEstudiante7State extends State<MatricularmeEstudiante7> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                width: 320,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildHeader(),
                    const SizedBox(height: 30),
                    _buildProgressIndicator(),
                    const SizedBox(height: 30),
                    _buildProfileSection(),
                    const SizedBox(height: 30),
                    _buildFormSection(),
                    const SizedBox(height: 30),
                    _buildActionButtons(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              border: Border.all(color: const Color(0xFFD9D9D9)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_back, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return SizedBox(
      width: 294,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildProgressStep(true),
          _buildProgressConnector(true),
          _buildProgressStep(true),
          _buildProgressConnector(true),
          _buildProgressStep(false),
        ],
      ),
    );
  }

  Widget _buildProgressStep(bool isActive) {
    return Container(
      width: 15,
      height: 15,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFE51F52) : const Color(0xFF666666),
        shape: BoxShape.circle,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFFE51F52) : const Color(0xFF666666),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressConnector(bool isActive) {
    return Container(
      width: 14,
      height: 1,
      color: isActive ? const Color(0xFFE51F52) : const Color(0xFF666666),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        CircleAvatar(
          radius: 33,
          backgroundColor: const Color(0xFFE51F52),
          child: const Icon(Icons.person, size: 35, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Container(
          width: 100,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xFF213354),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              'Estudiante',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Datos de Contacto del Estudiante',
          style: TextStyle(
            color: Color(0xFF3C578A),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        _buildTextField(label: 'Dirección', controller: _direccionController),
        const SizedBox(height: 20),
        _buildTextField(label: 'Email', controller: _emailController),
        const SizedBox(height: 20),
        _buildTextField(label: 'Celular', controller: _celularController),
        const SizedBox(height: 20),
        _buildTextField(label: 'Teléfono', controller: _telefonoController),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF213354),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
            ),
            hintStyle: const TextStyle(
              color: Color(0xFFA2A1A1),
              fontSize: 13,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Este campo es requerido';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return SizedBox(
      width: 240,
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _procesarFormulario();
                }
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(12),
                side: const BorderSide(color: Color(0xFF213354)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Siguiente',
                style: TextStyle(
                  color: Color(0xFF213354),
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE51F52),
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
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
      const SnackBar(content: Text('Formulario enviado correctamente')),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MatricularmeEstudiante8()),
    );
  }
}
