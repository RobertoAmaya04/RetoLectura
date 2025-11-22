import 'package:flutter/material.dart';
import 'package:retolectura/src/models/fakeData.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final libros = librosTest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        centerTitle: true,
        actions: [CircleAvatar(child: Icon(Icons.person))],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: libros.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.amber,
                      elevation: 4,
                      child: Container(
                        child: Text('texto'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
