import 'package:flutter/material.dart';
import 'package:apis/presentation/screens/contacto_representante.dart';

class InfoRepresentanteScreen extends StatefulWidget {
  const InfoRepresentanteScreen({Key? key}) : super(key: key);

  @override
  State<InfoRepresentanteScreen> createState() => _InfoRepresentanteScreenState();
}

class _InfoRepresentanteScreenState extends State<InfoRepresentanteScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _facturaNombreEstudiante = false;

  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  String? _selectedTipoID;
  String? _selectedOrigen;
  String? _selectedParroquia;
  String? _selectedEstadoCivil;
  String? _selectedGenero;

  final List<String> _tiposID = ['Cédula', 'Pasaporte'];
  final List<String> _origenes = ['Salario', 'Negocio', 'Otro'];
  final List<String> _parroquias = ['Parroquia A', 'Parroquia B'];
  final List<String> _estadosCiviles = ['Soltero/a', 'Casado/a'];
  final List<String> _generos = ['Masculino', 'Femenino', 'Otro'];

  @override
  void dispose() {
    _idNumberController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildProgress(),
                const SizedBox(height: 20),
                _buildProfileLabel(),
                const SizedBox(height: 20),
                _buildCheckbox(),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Tipo de Identificación',
                  value: _selectedTipoID,
                  items: _tiposID,
                  onChanged: (value) => setState(() => _selectedTipoID = value),
                  showAlert: true,
                ),
                _buildTextField('Número de identificación', _idNumberController),
                _buildTextField('Razón Social/Nombre Completo', _fullNameController),
                _buildDropdown(
                  label: 'Origen de ingresos',
                  value: _selectedOrigen,
                  items: _origenes,
                  onChanged: (value) => setState(() => _selectedOrigen = value),
                  showAlert: true,
                ),
                _buildDropdown(
                  label: 'Parroquia',
                  value: _selectedParroquia,
                  items: _parroquias,
                  onChanged: (value) => setState(() => _selectedParroquia = value),
                  showAlert: true,
                ),
                _buildDropdown(
                  label: 'Estado civil',
                  value: _selectedEstadoCivil,
                  items: _estadosCiviles,
                  onChanged: (value) => setState(() => _selectedEstadoCivil = value),
                  showAlert: true,
                ),
                _buildDropdown(
                  label: 'Género',
                  value: _selectedGenero,
                  items: _generos,
                  onChanged: (value) => setState(() => _selectedGenero = value),
                  showAlert: true,
                ),
                const SizedBox(height: 24),
                _buildActionButtons(),
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
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildProgress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        bool isFilled = index < 2;
        return Row(
          children: [
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: isFilled ? const Color(0xFFE51F52) : const Color(0xFFCCCCCC),
                shape: BoxShape.circle,
              ),
            ),
            if (index < 4)
              Container(
                width: 14,
                height: 1,
                color: const Color(0xFFE51F52),
              ),
          ],
        );
      }),
    );
  }

  Widget _buildProfileLabel() {
    return Column(
      children: const [
        CircleAvatar(
          radius: 33,
          backgroundColor: Color(0xFFE51F52),
          child: Icon(Icons.person, size: 35, color: Colors.white),
        ),
        SizedBox(height: 10),
        Text(
          'Representante',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            backgroundColor: Color(0xFF213354),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Información del representante',
          style: TextStyle(
            color: Color(0xFF3C578A),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _facturaNombreEstudiante,
          onChanged: (value) {
            setState(() {
              _facturaNombreEstudiante = value ?? false;
            });
          },
        ),
        const Text('Emitir facturas a nombre del estudiante'),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 4),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo obligatorio';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    bool showAlert = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label),
              if (showAlert)
                const Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Icon(Icons.error_outline, size: 18, color: Colors.red),
                )
            ],
          ),
          const SizedBox(height: 4),
          DropdownButtonFormField<String>(
            value: value,
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) => value == null ? 'Seleccione una opción' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactoRepresentScreen(),
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
              style: TextStyle(color: Color(0xFF213354)),
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
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
