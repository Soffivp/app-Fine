import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MenuHamburguesa extends StatelessWidget {
  const MenuHamburguesa({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_OpcionMenu> opciones = [
      _OpcionMenu('Matrículas', LucideIcons.clipboardList),
      _OpcionMenu('Cuotas', LucideIcons.dollarSign),
      _OpcionMenu('Notas', LucideIcons.graduationCap),
      _OpcionMenu('Asistencias', LucideIcons.userCheck),
      _OpcionMenu('Expediente', LucideIcons.folder),
      _OpcionMenu('Configuración', LucideIcons.settings),
      _OpcionMenu('Perfil', LucideIcons.user),
      _OpcionMenu('Fine Online', LucideIcons.rss),
    ];

    return Drawer(
      backgroundColor: const Color(0xFFF5F2F8),
      child: Column(
        children: [
          const SizedBox(height: 60),

          // Lista de opciones
          ...opciones.map(
                (opcion) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                leading: Icon(opcion.icono, color: const Color(0xFF1C2D5D), size: 22),
                title: Text(opcion.titulo,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF1C2D5D),
                    )),
                onTap: () {
                  Navigator.pop(context);
                  // Puedes hacer Navigator.pushNamed(context, '/ruta_correspondiente');
                },
                hoverColor: const Color(0xFFE0E4F0),
                splashColor: const Color(0xFFE0E4F0),
              ),
            ),
          ),

          const Spacer(),

          // Botón Cerrar Sesión
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text('Cerrar Sesión',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE51F52),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OpcionMenu {
  final String titulo;
  final IconData icono;

  _OpcionMenu(this.titulo, this.icono);
}
