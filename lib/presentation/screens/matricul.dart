import 'package:flutter/material.dart';

import 'matricula6.dart' show MatricularEstudianteForm6;

class MatricularEstudianteForm extends StatefulWidget {
  const MatricularEstudianteForm({Key? key}) : super(key: key);

  @override
  _MatricularEstudianteFormState createState() => _MatricularEstudianteFormState();  // CORRECTO

}

class _MatricularEstudianteFormState extends State<MatricularEstudianteForm> {
  final _formKey = GlobalKey<FormState>();
  String _ocupacion = 'Estudiante';
  String _nivelEducacion = 'Superior';
  String _lugarEstudioTrabajo = 'Loja';
  final TextEditingController _lugarController = TextEditingController();

  final List<String> _ocupaciones = ['Estudiante', 'Trabajador', 'Otro'];
  final List<String> _nivelesEducacion = [
    'Primaria',
    'Secundaria',
    'Superior',
    'Posgrado',
  ];

  @override
  void initState() {
    super.initState();
    _lugarController.text = _lugarEstudioTrabajo;
  }

  @override
  void dispose() {
    _lugarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: 360,
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            border: Border.all(color: const Color(0xFFD9D9D9)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.arrow_back, size: 20),
        ),
        const Spacer(),
        Image.network("https://placehold.co/42x35", width: 42, height: 35),
        const SizedBox(width: 5),
        Image.network("https://placehold.co/201x35", width: 200, height: 35),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return SizedBox(
      width: 294,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildProgressStep(1, true),
          _buildProgressConnector(true),
          _buildProgressStep(2, true),
          _buildProgressConnector(false),
          _buildProgressStep(3, false),
          _buildProgressConnector(false),
          _buildProgressStep(4, false),
        ],
      ),
    );
  }

  Widget _buildProgressStep(int step, bool isActive) {
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
              color: isActive
                  ? const Color(0xFFE51F52)
                  : const Color(0xFF666666),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressConnector(bool isActive) {
    return Expanded(
      child: Container(
        height: 1,
        color: isActive ? const Color(0xFFE51F52) : const Color(0xFF666666),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        Container(
          width: 66,
          height: 66,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFE51F52),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 30),
            ),
          ),
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
          'Datos Personales del Estudiante',
          style: TextStyle(
            color: Color(0xFF3C578A),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        _buildDropdownField(
          label: 'Ocupación',
          value: _ocupacion,
          items: _ocupaciones,
          onChanged: (value) {
            setState(() {
              _ocupacion = value.toString();
            });
          },
        ),
        const SizedBox(height: 20),
        _buildDropdownField(
          label: 'Nivel de Educación',
          value: _nivelEducacion,
          items: _nivelesEducacion,
          onChanged: (value) {
            setState(() {
              _nivelEducacion = value.toString();
            });
          },
        ),
        const SizedBox(height: 20),
        _buildTextField(
          label: 'Lugar de estudio/trabajo',
          controller: _lugarController,
          onChanged: (value) {
            setState(() {
              _lugarEstudioTrabajo = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required Function(dynamic) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFF213354), fontSize: 14),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFB3B3B3)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down),
            style: TextStyle(color: const Color(0xFFB3B3B3), fontSize: 13),
            items: items.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFF213354), fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
            ),
            hintText: 'Loja',
            hintStyle: TextStyle(color: const Color(0xFFA2A1A1), fontSize: 13),
          ),
          onChanged: onChanged,
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
              // Cambiar la navegación del botón Siguiente
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MatricularEstudianteForm6(),
                    ),
                  );
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
                style: TextStyle(color: Color(0xFF213354), fontSize: 16),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Acción para el botón Cancelar
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE51F52),
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
