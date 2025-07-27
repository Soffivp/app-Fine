import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFFE51F52)),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF213354)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                'https://placehold.co/250x50?text=FINE+TUNED+ENGLISH',
                height: 50,
              ),
            ),
            const SizedBox(height: 20),
            _buildUserCard(),
            const SizedBox(height: 15),
            _buildOnlineButton(),
            const SizedBox(height: 20),
            const Text('Anuncios / Noticias',
                style: TextStyle(color: Color(0xFF213354), fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            _buildTabNoticias(),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE51F52),
        onPressed: () {},
        child: const Icon(Icons.chat_bubble_outline),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget _buildUserCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE1E7F1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.person, size: 40, color: Color(0xFF213354)),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nahomi Astrid Cabrera Picoita', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Nro. Cédula: 1150057501'),
                Text('A1.0 English Express 1'),
                Text('nahomi777@email.com'),
              ],
            ),
          ),
          const Text('Ver más', style: TextStyle(color: Color(0xFF213354))),
          const Icon(Icons.chevron_right, color: Color(0xFF213354))
        ],
      ),
    );
  }

  Widget _buildOnlineButton() {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE51F52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text('Fine Online', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildTabNoticias() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF213354),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Académicos'),
                Tab(text: 'Eventos'),
              ],
            ),
          ),
          Container(
            height: 300,
            padding: const EdgeInsets.only(top: 10),
            child: TabBarView(
              children: [
                _buildNoticiasList([ // Noticias académicas
                  {
                    'titulo': 'Notas subidas',
                    'descripcion': 'Ahora ya puedes ver tus notas. ¡Te deseamos suerte!'
                  },
                  {
                    'titulo': 'Clases en línea',
                    'descripcion': 'Revisa el link enviado para que puedas ingresar a tus clases de hoy.'
                  },
                  {
                    'titulo': '¡Empiezan los exámenes!',
                    'descripcion': 'Prepárate esta semana empiezan los exámenes. ¡Mucha suerte!'
                  },
                  {
                    'titulo': 'Matrículas',
                    'descripcion': 'Recuerda completar tu matrícula antes del viernes.'
                  },
                ]),
                _buildNoticiasList([ // Eventos
                  {
                    'titulo': 'Festival de inglés',
                    'descripcion': 'El próximo lunes disfruta del festival cultural de inglés.'
                  },
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoticiasList(List<Map<String, String>> noticias) {
    return ListView.separated(
      itemCount: noticias.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final noticia = noticias[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.article_outlined, size: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(noticia['titulo']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(noticia['descripcion']!),
                  ],
                ),
              ),
              const Text('Ver más'),
              const Icon(Icons.chevron_right),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            IconButton(icon: Icon(Icons.home, color: Color(0xFFE51F52)), onPressed: null),
            IconButton(icon: Icon(Icons.article_outlined, color: Color(0xFFE51F52)), onPressed: null),
            SizedBox(width: 48), // espacio para FAB
            IconButton(icon: Icon(Icons.attach_money, color: Color(0xFFE51F52)), onPressed: null),
            IconButton(icon: Icon(Icons.person_outline, color: Color(0xFFE51F52)), onPressed: null),
          ],
        ),
      ),
    );
  }
}
