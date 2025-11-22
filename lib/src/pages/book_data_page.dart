import 'package:flutter/material.dart';
import 'package:retolectura/src/models/book.dart';
import 'package:retolectura/src/widgets/Utils.dart';

class BookDataPage extends StatelessWidget {
  final Book book;
  
  const BookDataPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name, style: TextStyle(color: Utils.textColor),),
        backgroundColor: Utils.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Aqui va las partes de la informacion del libro
          ],
        ),
      ),
    );
  }
}
