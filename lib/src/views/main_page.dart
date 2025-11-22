//la pagina donde se muestran los libros en fila y donde se pueden agregarmas libros

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:retolectura/src/models/libro_data_model.dart';
import 'package:retolectura/src/provider/data_provider.dart';
import 'package:retolectura/src/widgets/lib_data_tile.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.indigo[200],
        leading: Padding(
          padding: EdgeInsetsGeometry.all(5),
          child: ClipOval(
            child: FirebaseAuth.instance.currentUser!.photoURL != null
                ? Image.network(FirebaseAuth.instance.currentUser!.photoURL!)
                : Icon(Icons.person),
          ),
        ),
        title: Text('Reto Lectura'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.bar_chart))],
      ),

      body: StreamBuilder(
        stream: data.getAllLibroDataStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final List<LibroData> libroData = snapshot.data!;

          return ListView.builder(
            itemCount: libroData.length,
            itemBuilder: (BuildContext context, int index) {
              return LibTile(libData: libroData[index]);
            },
          );
        },
      ),

      // Scaffold(
      //   appBar: AppBar(title: Text('Pruebas')),
      //   body: StreamBuilder(
      //     stream: data.getAllLibroDataStream(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return Center(child: CircularProgressIndicator());
      //       }

      //       if (snapshot.hasError) {
      //         return Center(child: Text(snapshot.error.toString()));
      //       }

      //       final List<LibroData> libroData = snapshot.data!;

      //       return ListView.builder(
      //         itemCount: libroData.length,
      //         itemBuilder: (BuildContext context, int index) {
      //           return ListTile(
      //             leading: CircleAvatar(child: Text('RA')),
      //             title: Text(libroData[index].autor),
      //           );
      //         },
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
