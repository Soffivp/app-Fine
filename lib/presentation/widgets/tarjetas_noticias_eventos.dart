import 'package:flutter/material.dart';
import 'package:apis/presentation/widgets/tarjeta_noticias.dart';
import 'package:apis/presentation/widgets/tarjeta_eventos.dart';

class TarjetasNoticiasEventos extends StatelessWidget {
  const TarjetasNoticiasEventos({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF12224E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Académicos'),
                Tab(text: 'Eventos'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 350, // ajusta según la cantidad de tarjetas visibles
            child: const TabBarView(
              children: [
                TarjetasNoticias(),
                NotiEventos(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
