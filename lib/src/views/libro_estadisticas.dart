import 'package:flutter/material.dart';
import 'package:retolectura/src/models/libro_data_model.dart';

class LibroEstadisticasPage extends StatelessWidget {
  const LibroEstadisticasPage({super.key, this.libroData});
  final LibroData? libroData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.ac_unit),

        title: Text(
          'Estadisticas de libro',
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.settings), // tuerca
            onSelected: (value) {
              if (value == 'op1') {
                print("Opción 1 seleccionada"); //TODO: que lleve a actualizar
              } else if (value == 'op2') {
                print("Opción 2 seleccionada"); //TODO: que lleve a borrar
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'op1', child: Text("Opción 1")),
              PopupMenuItem(value: 'op2', child: Text("Opción 2")),
            ],
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  'https://images.icon-icons.com/317/PNG/512/book-bookmark-icon_34486.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 16),

            Text(
              "El príncipe",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            Text(
              "Nicholas Maquiavelo",
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),

            SizedBox(height: 30),

            Text(
              "Progreso",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            SizedBox(height: 9),

            Container(
              child: LinearProgressIndicator(
                value: 0.8, // entre 0.0 y 1.0
                minHeight: 10,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),

            SizedBox(height: 20),

            Text(
              "120 páginas leídas / 200 por leer",
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 12),

            Text(
              "Estado: Leyendo",
              style: TextStyle(fontSize: 16, color: Colors.blueAccent),
            ),

            SizedBox(height: 24),

            Text(
              "Comentarios",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8),

            TextField(
              maxLines: 4, // Caja más alta
              decoration: InputDecoration(
                hintText: "Escribe tus comentarios aquí...",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(4),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(onPressed: () {}, child: Text("Continuar")),
        ),
      ),
    );
  }
}
