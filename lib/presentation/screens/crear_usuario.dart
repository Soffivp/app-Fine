import 'package:apis/presentation/screens/login.dart';
import 'package:flutter/material.dart';
import '../widgets/boton_formulario.dart';
import '../widgets/encabezado_formulario.dart';
import 'package:apis/infrastructure/firestore/firebase_service.dart';
import 'package:apis/domain/entities/datos_estudiantes.dart';
import 'package:apis/presentation/screens/login.dart';

class CrearUsuarioForm extends StatefulWidget {
  const CrearUsuarioForm({Key? key}) : super(key: key);

  @override
  State<CrearUsuarioForm> createState() => _CrearUsuarioFormState();
}

class _CrearUsuarioFormState extends State<CrearUsuarioForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final TextEditingController _confirmarController = TextEditingController();
  bool _mostrarPassword = false;
  bool _mostrarConfirmacion = false;

  @override
  void dispose() {
    _usuarioController.dispose();
    _contrasenaController.dispose();
    _confirmarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 30),
                _buildProgressIndicator(),
                const SizedBox(height: 30),
                _buildProfileSection(),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                _buildMessageBox(),
                const SizedBox(height: 20),
                _buildTextField('Nombre de usuario', _usuarioController),
                const SizedBox(height: 20),
                _buildPasswordField('Contraseña', _contrasenaController, _mostrarPassword, () {
                  setState(() => _mostrarPassword = !_mostrarPassword);
                }),
                const SizedBox(height: 20),
                _buildPasswordField('Confirmar Contraseña', _confirmarController, _mostrarConfirmacion, () {
                  setState(() => _mostrarConfirmacion = !_mostrarConfirmacion);
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
      children: List.generate(5, (index) {
        final isActive = index < 5;
        return Row(
          children: [
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFFE51F52) : const Color(0xFF666666),
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
          width: 130,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xFF213354),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              'Crear Usuario',
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

  Widget _buildMessageBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF3C578A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Le recomendamos que su nombre de usuario sea la cédula. Recuerde que los nombres de usuario son únicos',
        style: TextStyle(color: Colors.white, fontSize: 13),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF213354), fontSize: 14)),
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

  Widget _buildPasswordField(String label, TextEditingController controller, bool visible, VoidCallback toggle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF213354), fontSize: 14)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: !visible,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(visible ? Icons.visibility : Icons.visibility_off, size: 18),
              onPressed: toggle,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
            ),
            hintStyle: const TextStyle(color: Color(0xFFA2A1A1), fontSize: 13),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Este campo es requerido';
            if (label == 'Confirmar Contraseña' && value != _contrasenaController.text) {
              return 'Las contraseñas no coinciden';
            }
            return null;
          },
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
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  await FirebaseService().guardarEstudianteYCredenciales(
                    nombreUsuario: _usuarioController.text.trim(),
                    contrasena: _contrasenaController.text.trim(),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Usuario registrado correctamente')),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) =>  Login()),
                  );

                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ocurrió un error al guardar en Firestore')),
                  );
                }
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
