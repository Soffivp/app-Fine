import 'package:flutter/material.dart';
import '../widgets/encabezado_formulario.dart';
import '../widgets/boton_formulario.dart';
import 'package:apis/presentation/screens/matricula6.dart';

class MatricularEstudianteForm1 extends StatefulWidget {
  const MatricularEstudianteForm1({Key? key}) : super(key: key);

  @override
  State<MatricularEstudianteForm1> createState() => _MatricularEstudianteForm1State();
}

class _MatricularEstudianteForm1State extends State<MatricularEstudianteForm1> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _identificacionController = TextEditingController();
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  DateTime? _fechaNacimiento;

  String _tipoIdentificacion = 'Cédula';
  String _genero = 'Femenino';

  final List<String> _tiposIdentificacion = ['Cédula', 'Pasaporte'];
  final List<String> _generos = ['Femenino', 'Masculino', 'Otro'];

  @override
  void dispose() {
    _identificacionController.dispose();
    _nombresController.dispose();
    _apellidosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 30),
                _buildProgressIndicator(),
                const SizedBox(height: 30),
                _buildProfileSection(),
                const SizedBox(height: 30),
                const EncabezadoFormulario(titulo: 'Datos Personales del Estudiante'),
                const SizedBox(height: 20),
                _buildDropdownField('Tipo de Identificación', _tipoIdentificacion, _tiposIdentificacion, (val) {
                  setState(() => _tipoIdentificacion = val);
                }),
                const SizedBox(height: 20),
                _buildTextField('Número de identificación', _identificacionController),
                const SizedBox(height: 20),
                _buildTextField('Nombre/s', _nombresController),
                const SizedBox(height: 20),
                _buildTextField('Apellido/s', _apellidosController),
                const SizedBox(height: 20),
                _buildDateField('Fecha de Nacimiento'),
                const SizedBox(height: 20),
                _buildDropdownField('Género', _genero, _generos, (val) {
                  setState(() => _genero = val);
                }),
                const SizedBox(height: 30),
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
        Image.network("https://placehold.co/42x35", width: 42, height: 35),
        const SizedBox(width: 5),
        Image.network("https://placehold.co/201x35", width: 200, height: 35),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProgressStep(1, true),
        _buildProgressConnector(true),
        _buildProgressStep(2, false),
        _buildProgressConnector(false),
        _buildProgressStep(3, false),
      ],
    );
  }

  Widget _buildProgressStep(int step, bool isActive) {
    return Container(
      width: 15,
      height: 15,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFE51F52) : const Color(0xFF666666),
        shape: BoxShape.circle,
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
        Container(
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

  Widget _buildTextField(String label, TextEditingController controller) {
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
            ),
            hintStyle: const TextStyle(color: Color(0xFFA2A1A1), fontSize: 13),
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

  Widget _buildDropdownField(String label, String value, List<String> items, void Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF213354), fontSize: 14)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD9D9D9)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down),
            items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (val) => onChanged(val!),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF213354), fontSize: 14)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              setState(() => _fechaNacimiento = picked);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFD9D9D9)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _fechaNacimiento != null ?
                  '${_fechaNacimiento!.day.toString().padLeft(2, '0')}/${_fechaNacimiento!.month.toString().padLeft(2, '0')}/${_fechaNacimiento!.year}'
                      : 'Seleccione una fecha',
                  style: const TextStyle(color: Color(0xFFA2A1A1), fontSize: 13),
                ),
                const Icon(Icons.calendar_today, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: BotonFormulario(
            texto: 'Siguiente',
            color: Colors.white,
            textoColor: const Color(0xFF213354),
            bordeColor: const Color(0xFF213354),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MatricularEstudianteForm6()),
                );
              }
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: BotonFormulario(
            texto: 'Cancelar',
            color: const Color(0xFFE51F52),
            textoColor: Colors.white,
            bordeColor: const Color(0xFFE51F52),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}
