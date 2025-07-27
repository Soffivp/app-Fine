import 'package:flutter/material.dart';
import 'package:apis/presentation/screens/crear_usuario.dart';

class ContactoRepresentScreen extends StatefulWidget {
  const ContactoRepresentScreen({super.key});

  @override
  State<ContactoRepresentScreen> createState() => _ContactoRepresentScreenState();
}

class _ContactoRepresentScreenState extends State<ContactoRepresentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _direccionController = TextEditingController();
  final _emailController = TextEditingController();
  final _celularController = TextEditingController();
  final _telefonoController = TextEditingController();

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
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
          bool isActive = index < 3;
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
                    decoration: const BoxDecoration(
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
        Center(
          child: Container(
            width: 66,
            height: 66,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFFE51F52),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 30),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 180,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xFF213354),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              'Representante',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Datos de contacto del representante',
          style: TextStyle(
            color: Color(0xFF3C578A),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(label: 'Dirección', controller: _direccionController),
        const SizedBox(height: 20),
        _buildTextField(label: 'Email', controller: _emailController),
        const SizedBox(height: 20),
        _buildTextField(label: 'Celular (Grupo WhatsApp)', controller: _celularController),
        const SizedBox(height: 20),
        _buildTextField(label: 'Teléfono', controller: _telefonoController),
      ],
    );
  }

  Widget _buildTextField({required String label, required TextEditingController controller}) {
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
          validator: (value) => (value == null || value.isEmpty) ? 'Este campo es requerido' : null,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CrearUsuarioForm(),
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
