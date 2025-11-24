import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:retolectura/src/models/libro_data_model.dart';
import 'package:retolectura/src/provider/data_provider.dart';

class LibroEstadisticasPage extends StatefulWidget {
  const LibroEstadisticasPage({super.key, required this.libroData});
  final LibroData libroData;

  @override
  State<LibroEstadisticasPage> createState() => _LibroEstadisticasPageState();
}

class _LibroEstadisticasPageState extends State<LibroEstadisticasPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double progreso =
        (widget.libroData.pagLeidas) / (widget.libroData.pagTotales);

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
        backgroundColor: Color(0xFF9C27B0),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.settings),
            onSelected: (value) async {
              if (value == 'actualizar') {
                final res = await context.pushNamed(
                  'edit_book',
                  extra: widget.libroData,
                );

                if (context.mounted) {
                  context.pop(res);
                }
              } else if (value == 'borrar') {
                LibroDataProvider().deleteData(widget.libroData.toJson());
                context.pop(true);
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
      //extendBodyBehindAppBar: true,
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
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.libroData.portada,
                      width: 200,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 24),

                Text(
                  widget.libroData.titulo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  widget.libroData.autor,
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
                  "${widget.libroData.pagLeidas} páginas leídas / ${widget.libroData.pagTotales} totales",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),

                SizedBox(height: 12),

                Text(
                  "Estado: ${widget.libroData.estado}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.amberAccent,
                    fontStyle: FontStyle.italic,
                  ),
                ),

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
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Color(0xFF9C27B0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                final newLibro = context.goNamed(
                  'cronometro',
                  extra: widget.libroData,
                );
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
      ),
    );
  }
}
