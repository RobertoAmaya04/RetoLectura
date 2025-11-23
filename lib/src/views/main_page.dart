
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:retolectura/src/models/libro_data_model.dart';
import 'package:retolectura/src/provider/data_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final data = LibroDataProvider();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.2),
            child: ClipOval(
              child: FirebaseAuth.instance.currentUser?.photoURL != null
                  ? Image.network(FirebaseAuth.instance.currentUser!.photoURL!, fit: BoxFit.cover)
                  : const Icon(Icons.person, color: Colors.white),
            ),
          ),
        ),
        title: const Text(
          'Reto Lectura',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed('global_metrics');
            },
            icon: const Icon(Icons.bar_chart, color: Colors.white),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6A1B9A), // Deep Purple
              Color(0xFF9C27B0), // Purple
              Color(0xFFE040FB), // Bright Purple/Fuchsia
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: StreamBuilder<List<LibroData>>(
          stream: data.getAllLibroDataStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay libros en tu colección.', style: TextStyle(color: Colors.white)));
            }

            final List<LibroData> libroData = snapshot.data!;

            return GridView.builder(
              padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + kToolbarHeight + 16, 16, 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2 / 3, 
              ),
              itemCount: libroData.length,
              itemBuilder: (BuildContext context, int index) {
                final libro = libroData[index];
                return GestureDetector(
                  onTap: () {
                    // Navegación sin implementar lógica, como se solicitó
                    print("Tapped on ${libro.titulo}");
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Ink.image(
                      image: NetworkImage(
                        libro.portada ?? 'https://images.icon-icons.com/317/PNG/512/book-bookmark-icon_34486.png',
                      ),
                      fit: BoxFit.cover,
                      child: InkWell(
                        onTap: () {
                          // Lógica al presionar la tarjeta
                          print("Tapped on ${libro.titulo}");
                           context.go('/libro-estadisticas', extra: libro);
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: () {
           context.go('/add-book');
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Color(0xFF6A1B9A)),
      ),
    );
  }
}

