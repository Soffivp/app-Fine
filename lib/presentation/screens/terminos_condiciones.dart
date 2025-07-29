import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:apis/presentation/providers/registro_provider.dart';
import 'package:apis/presentation/widgets/boton_formulario.dart';
import 'package:apis/presentation/widgets/encabezado_formulario.dart';
import 'package:apis/presentation/widgets/barra_progreso.dart';
import 'package:apis/presentation/widgets/boton_atras.dart';
import 'package:apis/config/helpers/alerta_emergente.dart';

class TerminosCondicionesScreen extends StatefulWidget {
  const TerminosCondicionesScreen({super.key});

  @override
  State<TerminosCondicionesScreen> createState() => _TerminosCondicionesScreenState();
}

class _TerminosCondicionesScreenState extends State<TerminosCondicionesScreen> {
  bool _aceptaTerminos = false;

  void _guardarDatos(BuildContext context, RegistroProvider registroProvider) async {
    try {
      await registroProvider.guardarTodo(
        onSuccess: () {
          _mostrarDialogoExito(context);
        },
        onError: (error) {
          AlertaEmergente.mostrar(
            context,
            icono: Icons.error_outline,
            mensaje: 'Ocurrió un error al registrar: $error',
          );
        },
      );
    } catch (e) {
      AlertaEmergente.mostrar(
        context,
        icono: Icons.error_outline,
        mensaje: 'Error inesperado: $e',
      );
    }
  }

  void _mostrarDialogoExito(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, size: 48, color: Color(0xFFE51F52)),
            const SizedBox(height: 16),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(fontSize: 14, color: Colors.black),
                children: [
                  TextSpan(text: 'Felicidades ha completado su\n'),
                  TextSpan(
                    text: 'matrícula exitosamente.\n',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1C2D5D)),
                  ),
                  TextSpan(text: 'Gracias por confiar en nosotros.'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check, color: Colors.white, size: 18),
                label: const Text('Iniciar Sesión', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE51F52),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final registroProvider = Provider.of<RegistroProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(alignment: Alignment.topLeft, child: BotonAtras()),
              const SizedBox(height: 12),
              Image.asset('assets/images/imagen_margen.jpg', height: 60),
              const SizedBox(height: 8),
              const ProgresoRegistro(pasoActual: 8),
              const SizedBox(height: 16),
              const Icon(Icons.account_circle, size: 80, color: Color(0xFFDE0059)),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C2D5D),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Crear Usuario', style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF3C578A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: Colors.white),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Le informamos que el documento sobre los términos y condiciones será enviado al correo del representante.',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Contenedor con scroll para términos
              Container(
                height: 300,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: const Text(
                      '''[Al realizar una matrícula de cualquier servicio a finetunedenglish.edu.ec o proporcionar información confidencial ya sea a través de formularios de contacto y/o de suscripción a listas de correo electrónico, el cliente acepta expresamente y en su totalidad los acuerdos denominados "Políticas de privacidad".

RECOPILACIÓN DE INFORMACIÓN PERSONAL
Le solicitaremos información que le identifique personalmente (información personal) o que nos permita ponernos en contacto con usted cuando sea necesario para proporcionar un servicio o información necesaria del alumno, además realizar un cobro o recordatorio de transacción que usted haya solicitado y(o) adeude. La información personal recopilada puede incluir su nombre, el nombre de la empresa u organización, el correo electrónico del trabajo, el teléfono del trabajo, la dirección particular o del trabajo, información acerca de su empresa e información de su tarjeta de crédito, así como información relacionada con números de teléfono, cuentas de correo electrónico y otros que mantenga directa relación con nuestros servicios, todos denominados aquí como información personal.
]''',
                      style: TextStyle(fontSize: 13, height: 1.6),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Fila corregida para evitar overflow
              Row(
                children: [
                  Checkbox(
                    value: _aceptaTerminos,
                    onChanged: (val) => setState(() => _aceptaTerminos = val ?? false),
                    activeColor: const Color(0xFFE51F52),
                  ),
                  const Flexible(
                    child: Text(
                      'Acepto los términos y condiciones',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BotonFormulario(
                    texto: 'Siguiente',
                    color: Colors.white,
                    textoColor: const Color(0xFF213354),
                    bordeColor: const Color(0xFF213354),
                    habilitado: _aceptaTerminos,
                    onPressed: () {
                      _guardarDatos(context, registroProvider);
                    },
                  ),
                  const SizedBox(width: 12),
                  BotonFormulario(
                    texto: 'Cancelar',
                    color: const Color(0xFFE51F52),
                    textoColor: Colors.white,
                    bordeColor: Colors.transparent,
                    habilitado: true,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
