import 'package:flutter/material.dart';
import 'package:apis/domain/entities/pago.dart';
import 'package:apis/infrastructure/firestore/firebase_service.dart';
import 'package:apis/presentation/widgets/campo_estandar.dart';
import 'package:apis/presentation/widgets/boton_formulario.dart';
import 'package:apis/presentation/widgets/menu_inferior.dart';

class DepositoMatriculaScreen extends StatefulWidget {
  const DepositoMatriculaScreen({super.key});

  @override
  State<DepositoMatriculaScreen> createState() => _DepositoMatriculaScreenState();
}

class _DepositoMatriculaScreenState extends State<DepositoMatriculaScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _referenciaController = TextEditingController();
  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _fechaDepositoController = TextEditingController();
  final TextEditingController _idDepositaController = TextEditingController();

  Future<void> _seleccionarFecha() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      helpText: 'Selecciona la fecha de depósito',
      locale: const Locale('es', 'ES'),
    );

    if (picked != null) {
      final fechaFormateada = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      setState(() {
        _fechaDepositoController.text = fechaFormateada;
      });
    }
  }

  void _registrarPago() async {
    if (_formKey.currentState!.validate()) {
      final nuevoPago = Pago(
        referencia: _referenciaController.text.trim(),
        monto: double.tryParse(_montoController.text.trim()) ?? 0.0,
        fechaDeposito: _fechaDepositoController.text.trim(),
        idDeposita: _idDepositaController.text.trim(),
        cuentaBancaria: "", // ya no se usa, pero sigue existiendo en el modelo
      );

      await FirebaseService().guardarPago(nuevoPago);

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.folder_copy_outlined, size: 50, color: Color(0xFFE51F52)),
              const SizedBox(height: 16),
              const Text(
                'Datos del depósito/transferencia\nenviados con éxito.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              const Text(
                'Le responderemos lo más\npronto posible.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              BotonFormulario(
                texto: 'Volver al inicio',
                color: const Color(0xFFE51F52),
                textoColor: Colors.white,
                bordeColor: const Color(0xFFE51F52),
                onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/home')),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: MenuInferior(indexActual: 2),
      appBar: AppBar(
        title: const Text(
          'DEPÓSITO / TRANSFERENCIA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFE51F52),
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications_none, color: Colors.black),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset('assets/images/imagen_margen.jpg', height: 80),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3F3),
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.red),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Si usted realizó el pago utilizando papeleta o transferencia, registre aquí los datos del comprobante.',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              CampoEstandar(
                label: 'Nro. referencia',
                hintText: 'Ingrese número de referencia',
                controller: _referenciaController,
                keyboardType: TextInputType.text,
                habilitado: true,
              ),
              CampoEstandar(
                label: 'Monto depósito',
                hintText: 'Ingrese monto del depósito',
                controller: _montoController,
                keyboardType: TextInputType.number,
                habilitado: true,
              ),
              GestureDetector(
                onTap: _seleccionarFecha,
                child: AbsorbPointer(
                  child: CampoEstandar(
                    label: 'Fecha depósito',
                    hintText: 'Ej: 14/06/2025',
                    controller: _fechaDepositoController,
                    keyboardType: TextInputType.datetime,
                    habilitado: true,
                  ),
                ),
              ),
              CampoEstandar(
                label: 'ID deposita',
                hintText: 'Ingrese ID de quien deposita',
                controller: _idDepositaController,
                keyboardType: TextInputType.text,
                habilitado: true,
                iconoInfo: true,
                onIconPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Este campo es obligatorio para verificar identidad.')),
                  );
                },
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: BotonFormulario(
                      texto: 'Registrar',
                      color: const Color(0xFF003366),
                      textoColor: Colors.white,
                      bordeColor: const Color(0xFF003366),
                      onPressed: _registrarPago,
                    ),
                  ),
                  const SizedBox(width: 12),
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
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
