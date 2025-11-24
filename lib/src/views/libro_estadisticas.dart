import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:retolectura/src/models/libro_data_model.dart';

class LibroEstadisticasPage extends StatelessWidget {
  const LibroEstadisticasPage({super.key, required this.libroData});
  final LibroData libroData;

  @override
  Widget build(BuildContext context) {
    double progreso = (libroData.pagLeidas) / (libroData.pagTotales);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Estadísticas del Libro',
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.settings),
            onSelected: (value) {
              if (value == 'actualizar') {
                context.goNamed('edit_book', extra: libroData);
              } else if (value == 'borrar') {
                print(
                  "Opción de borrar seleccionada",
                ); //TODO: Implementar lógica de borrado
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'actualizar',
                child: Text("Actualizar libro"),
              ),
              PopupMenuItem(value: 'borrar', child: Text("Borrar libro")),
            ],
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
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
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    libroData.portada ??
                        'https://images.icon-icons.com/317/PNG/512/book-bookmark-icon_34486.png',
                    width: 200,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(height: 24),

              Text(
                libroData.titulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 8),

              Text(
                libroData.autor,
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),

              SizedBox(height: 30),

              Text(
                "Progreso",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 12),

              LinearProgressIndicator(
                value: progreso,
                minHeight: 12,
                backgroundColor: Colors.white.withValues(alpha: 0.3),
                valueColor: AlwaysStoppedAnimation(Colors.white),
                borderRadius: BorderRadius.circular(6),
              ),

              SizedBox(height: 12),

              Text(
                "${libroData.pagLeidas} páginas leídas / ${libroData.pagTotales} totales",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),

              SizedBox(height: 12),

              Text(
                "Estado: ${libroData.estado}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.amberAccent,
                  fontStyle: FontStyle.italic,
                ),
              ),

              SizedBox(height: 30),

              Text(
                "Comentarios",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 12),

              // TextField(
              //   controller: TextEditingController(text: libroData.comentarios),
              //   maxLines: 4,
              //   style: const TextStyle(color: Colors.white),
              //   decoration: InputDecoration(
              //     hintText: "Escribe tus comentarios aquí...",
              //     hintStyle: const TextStyle(color: Colors.white70),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(12),
              //       borderSide: const BorderSide(color: Colors.white54),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(12),
              //       borderSide: const BorderSide(color: Colors.white),
              //     ),
              //     fillColor: Colors.white.withOpacity(0.1),
              //     filled: true,
              //   ),
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              context.goNamed('cronometro', extra: libroData);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Continuar Lectura",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF6A1B9A), // Deep Purple
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
