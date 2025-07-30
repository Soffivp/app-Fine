import 'package:flutter/material.dart';
import 'package:apis/presentation/widgets/cuadroA_info.dart';
import 'package:apis/presentation/widgets/menu_hamburgesa.dart';
import 'package:apis/presentation/widgets/menu_inferior.dart';
import 'package:apis/presentation/widgets/campo_estandar.dart';
import 'package:apis/config/router/app_routes.dart'; // ✅ Import necesario

class PagoMatriculaScreen extends StatefulWidget {
  const PagoMatriculaScreen({super.key});

  @override
  State<PagoMatriculaScreen> createState() => _PagoMatriculaScreenState();
}

class _PagoMatriculaScreenState extends State<PagoMatriculaScreen> {
  String metodoPago = "Depósito o transferencia";
  int cuotas = 1;
  String medioEnterado = "Contacto de Asesores Comerciales";

  @override
  Widget build(BuildContext context) {
    double total = 109.00;
    double descuento = cuotas == 1 ? 5.00 : 0.00;
    double totalConDescuento = total - descuento;
    double totalFinal = cuotas == 1 ? totalConDescuento : total / 2;

    return Scaffold(
      drawer: const MenuHamburguesa(),
      bottomNavigationBar: const MenuInferior(indexActual: 1),
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFE51F52)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'PAGO MATRÍCULA',
          style: TextStyle(
            color: Color(0xFFE51F52),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications_none, color: Colors.black),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/imagen_margen.jpg', height: 70),
            const SizedBox(height: 10),
            const CuadroAInfo(),
            const SizedBox(height: 20),

            CampoEstandar(
              label: 'Método de pago',
              hintText: 'Selecciona una opción',
              items: const [
                'Depósito o transferencia',
                'Efectivo',
                'Tarjeta de crédito'
              ],
              value: metodoPago,
              onChanged: (value) {
                setState(() {
                  metodoPago = value!;
                });
              },
              habilitado: true,
            ),
            const SizedBox(height: 12),

            CampoEstandar(
              label: 'Cuotas a pagar',
              hintText: 'Selecciona número de cuotas',
              items: const ['1', '2'],
              value: cuotas.toString(),
              onChanged: (value) {
                setState(() {
                  cuotas = int.parse(value!);
                });
              },
              habilitado: true,
            ),
            const SizedBox(height: 12),

            CampoEstandar(
              label: '¿Por qué medio se enteró de nosotros?',
              hintText: 'Selecciona una opción',
              items: const [
                'Contacto de Asesores Comerciales',
                'Redes Sociales',
                'Recomendación',
                'Publicidad física',
              ],
              value: medioEnterado,
              onChanged: (value) {
                setState(() {
                  medioEnterado = value!;
                });
              },
              habilitado: true,
            ),
            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1C2D5D),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.description, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Detalle', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('ENGLISH EXPRESS - Richard Ortiz', style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 10),
                  Text('Cant. Cuotas: $cuotas', style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 10),
                  Text('Valor: \$${total.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 10),
                  Text('Descuento: \$${descuento.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 10),
                  Text('TOTAL: \$${totalFinal.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text('SALDO CUENTA: \$0.00', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE51F52)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_outlined, color: Color(0xFFE51F52)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Para continuar la inscripción registra el pago realizado. El monto es de \$${totalFinal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Color(0xFFE51F52),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Botón que redirecciona a /deposito-matricula
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.depositoMatricula);
                },
                icon: const Icon(Icons.payment, color: Colors.white),
                label: const Text("Datos del depósito"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE51F52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
