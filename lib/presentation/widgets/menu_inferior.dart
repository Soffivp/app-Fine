import 'package:flutter/material.dart';

class MenuInferior extends StatelessWidget {
  final int indexActual;

  const MenuInferior({super.key, required this.indexActual});

  void _navegar(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/misClases');
        break;
      case 2:
        Navigator.pushNamed(context, '/matricularse');
        break;
      case 3:
        Navigator.pushNamed(context, '/cuotas');
        break;
      case 4:
        Navigator.pushNamed(context, '/perfil');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: indexActual,
      onTap: (index) => _navegar(context, index),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: [
        _crearItem(icono: Icons.home, index: 0),
        _crearItem(icono: Icons.assignment, index: 1),
        _crearItem(icono: Icons.attach_money, index: 2),
        _crearItem(icono: Icons.school, index: 3),
        _crearItem(icono: Icons.person, index: 4),
      ],
    );
  }

  BottomNavigationBarItem _crearItem({required IconData icono, required int index}) {
    final bool activo = index == indexActual;
    return BottomNavigationBarItem(
      label: '',
      icon: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: activo ? const Color(0xFFE51F52) : const Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icono,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
