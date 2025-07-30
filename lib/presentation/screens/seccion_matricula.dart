import 'package:flutter/material.dart';
import 'package:apis/presentation/widgets/menu_hamburgesa.dart';
import 'package:apis/presentation/widgets/menu_inferior.dart';
import 'package:apis/presentation/widgets/tarjetas_cursos_contenedor.dart';

class SeccionMatriculaScreen extends StatelessWidget {
  const SeccionMatriculaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double anchoContenedor = MediaQuery.of(context).size.width * 0.88;

    return Scaffold(
      drawer: const MenuHamburguesa(),
      bottomNavigationBar: const MenuInferior(indexActual: 1),
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        // Ícono personalizado que abre el Drawer
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFFE51F52)),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          'Matricularme',
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
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: Column(
            children: [
              // Logo
              Image.asset(
                'assets/images/imagen_margen.jpg',
                height: 70,
              ),
              const SizedBox(height: 16),

              // Contenedor rojo con texto centrado e ícono
              Container(
                width: anchoContenedor,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE51F52),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.info_outline, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Selecciona el paralelo en el que deseas matricularte',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Tarjetas de cursos (con mismo ancho)
              TarjetasCursosContenedor(ancho: anchoContenedor),
            ],
          ),
        ),
      ),
    );
  }
}
