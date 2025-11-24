import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:retolectura/src/models/libro_data_model.dart';

class LibTile extends StatelessWidget {
  const LibTile({super.key, required this.libData});
  final LibroData libData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(libData.portada),

      title: Text(libData.titulo),

      subtitle: Column(
        children: [
          Text("Progreso"),
          SizedBox(height: 2),
          Text('${libData.pagLeidas}/${libData.pagTotales}'),
          SizedBox(height: 2),
          LinearProgressIndicator(
            value: 0.8, // entre 0.0 y 1.0
            minHeight: 10,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
          SizedBox(height: 2),
          Row(
            children: [Text('Estado: ${libData.estado}'), SizedBox(), Text('')],
          ),
        ],
      ),

      trailing: Icon(Icons.settings),
    );
  }
}
