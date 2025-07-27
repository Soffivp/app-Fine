import 'package:flutter/material.dart';
import 'package:apis/presentation/screens/info_represent.dart';

class MatricularmeEstudiante8 extends StatefulWidget {
  const MatricularmeEstudiante8({super.key});

  @override
  State<MatricularmeEstudiante8> createState() => _MatricularmeEstudiante8State();
}

class _MatricularmeEstudiante8State extends State<MatricularmeEstudiante8> {
  String? _establecimiento;
  String? _programaSeleccionado;
  final List<String> programas = ['ENGLISH EXPRESS', 'ENGLISH KIDS', 'TEENS ADVANCED'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 320,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildHeader(),
                  const SizedBox(height: 20),
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
        Image.network(
          'https://placehold.co/200x35?text=LOGO',
          width: 200,
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return SizedBox(
      width: 294,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          bool isActive = true;
          return Row(
            children: [
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: isActive ? const Color(0xFFE51F52) : const Color(0xFF666666),
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
                          color: isActive ? const Color(0xFFE51F52) : const Color(0xFF666666),
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
          'Datos académicos',
          style: TextStyle(
            color: Color(0xFF3C578A),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Establecimiento',
          style: TextStyle(fontSize: 14, color: Color(0xFF213354)),
        ),
        _buildRadio('Loja'),
        _buildRadio('Zamora'),
        _buildRadio('Yantzaza'),
        const SizedBox(height: 20),
        const Text(
          'Programa académico',
          style: TextStyle(fontSize: 14, color: Color(0xFF213354)),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _programaSeleccionado,
          items: programas.map((String programa) {
            return DropdownMenuItem<String>(
              value: programa,
              child: Text(programa),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _programaSeleccionado = value;
            });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
      ],
    );
  }

  Widget _buildRadio(String label) {
    return RadioListTile<String>(
      title: Text(label),
      value: label,
      activeColor: const Color(0xFF213354),
      groupValue: _establecimiento,
      onChanged: (value) {
        setState(() {
          _establecimiento = value;
        });
      },
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () {
            if (_establecimiento != null && _programaSeleccionado != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InfoRepresentanteScreen(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Por favor selecciona establecimiento y programa académico.'),
                ),
              );
            }
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            side: const BorderSide(color: Color(0xFF213354)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Siguiente', style: TextStyle(color: Color(0xFF213354))),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE51F52),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
