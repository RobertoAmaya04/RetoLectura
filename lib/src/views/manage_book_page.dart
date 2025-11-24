import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:retolectura/src/models/libro_data_model.dart';
import 'package:retolectura/src/provider/data_provider.dart';
import 'package:retolectura/src/widgets/snackbar_personalizado.dart';
import 'package:retolectura/src/widgets/style_default.dart';

class ManageBookPage extends StatelessWidget {
  final LibroDataProvider dp = LibroDataProvider();
  final LibroData? book;
  ManageBookPage({super.key, this.book});

  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final imageController = TextEditingController();
  final totalPageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (book != null) {
      titleController.text = book!.titulo;
      authorController.text = book!.autor;
      imageController.text = book!.portada ?? "";
      totalPageController.text = book!.pagTotales.toString();
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          book == null ? 'Agregar Libro' : 'Editar Libro',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                CustomTextField(
                  labelText: 'Titulo',
                  icon: Icons.book,
                  controller: titleController,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Autor',
                  icon: Icons.person,
                  controller: authorController,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  labelText: 'URL de la Portada',
                  icon: Icons.image,
                  controller: imageController,
                  keyboardType: TextInputType.url,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Numeros de Paginas',
                  icon: Icons.format_list_numbered,
                  controller: totalPageController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {

                      if (titleController.text.trim().isEmpty) {
                        CustomSnackBar.show(context,
                            message: 'Por favor, ingresa un título.');
                        return;
                      }
                      if (authorController.text.trim().isEmpty) {
                        CustomSnackBar.show(context,
                            message: 'Por favor, ingresa un autor.');
                        return;
                      }
                       if (imageController.text.trim().isEmpty) {
                        CustomSnackBar.show(context,
                            message: 'Por favor, ingresa la URL de la portada.');
                        return;
                      }
                      if (totalPageController.text.trim().isEmpty) {
                        CustomSnackBar.show(context,
                            message: 'Por favor, ingresa el número de páginas.');
                        return;
                      }
                      final totalPagesInt = int.tryParse(totalPageController.text.trim());
                      if (totalPagesInt == null || totalPagesInt <= 0) {
                        CustomSnackBar.show(context,
                            message: 'Ingresa un número de páginas válido.');
                        return;
                      }

                      if (book == null) {
                        dp.saveData({
                          'autor': authorController.text,
                          'titulo': titleController.text,
                          'img_portada': imageController.text,
                          'pag_totales': int.parse(totalPageController.text),
                          'estado': "pediente",
                          'pag_leidas': 0,
                          'tiempo_total': 0,
                        });
                        CustomSnackBar.show(context, message: 'Libro agregado.');
                        return;
                      }

                      dp.updateData({
                        'autor': authorController.text,
                        'titulo': titleController.text,
                        'img_portada': imageController.text,
                        'pag_totales': int.parse(totalPageController.text),
                        'id': book!.id,
                      });
                      CustomSnackBar.show(context, message: 'Libro actualizado.');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Guardar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF6A1B9A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
