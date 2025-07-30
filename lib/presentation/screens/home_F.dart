import 'package:flutter/material.dart';
import 'package:apis/presentation/widgets/menu_hamburgesa.dart';
import 'package:apis/presentation/widgets/cuadroA_info.dart';
import 'package:apis/presentation/widgets/menu_inferior.dart';
import 'package:apis/presentation/widgets/tarjetas_noticias_eventos.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuHamburguesa(),
      bottomNavigationBar: const MenuInferior(indexActual: 0),
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFFE51F52)),
            onPressed: () => Scaffold.of(context).openDrawer(),
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Center(
              child: Image.asset(
                'assets/images/imagen_margen.jpg',
                height: 70,
              ),
            ),
            const SizedBox(height: 8),

            // Info del estudiante
            const CuadroAInfo(),
            const SizedBox(height: 12),

            // Botón Fine Online
            SizedBox(
              width: 180,
              height: 42,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.rss_feed, color: Colors.white, size: 18),
                label: const Text('Fine Online'),
                onPressed: () {
                  // Acción futura
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE51F52),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Título
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Anuncios / Noticias',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),

            // Tarjetas de Noticias y Eventos (tabs)
            const TarjetasNoticiasEventos(),
          ],
        ),
      ),
    );
  }
}
