import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:retolectura/src/models/libro_data_model.dart';

class LibroDataProvider {
  Future<List<LibroData>> getAllLibroData() async {
    final db = FirebaseFirestore.instance;
    final collectionRefLibData = db
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books');

    final snapshotTodos = await collectionRefLibData.get();

    final libroData = List<LibroData>.from(
      snapshotTodos.docs.map((libroData) {
        return LibroData.fromJson({...libroData.data()});
      }),
    );

    return libroData;
    //return librosTest;
  }

  Stream<List<LibroData>> getAllLibroDataStream() {
    final db = FirebaseFirestore.instance;
    final collectionRefLibData = db
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books');

    final snapshotTodos = collectionRefLibData.snapshots();

    final lib = snapshotTodos.map((snapshot) {
      return snapshot.docs.map((libData) {
        return LibroData.fromJson({...libData.data()});
      }).toList();
    });

    return lib;

    // return Stream.value(librosTest);
  }

  Future<void> saveData(Map<String, dynamic> libroData) async {
    final db = FirebaseFirestore.instance;
    final idDisponible = await getPrimerIdDisponible();
    if (idDisponible == null) {
      return;
    }
    libroData['id'] = idDisponible;

    final collectionRefLibData = db
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books');

    await collectionRefLibData.doc(idDisponible.toString()).set(libroData);
  }

  Future<void> updateData(Map<String, dynamic> libroData) async {
    final db = FirebaseFirestore.instance;

    final id = libroData['id'];

    final collectionRefLibData = db
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books');
    await collectionRefLibData.doc(id.toString()).update(libroData);
  }

  Future<int?> getPrimerIdDisponible() async {
    // IDs posibles del 1 al 12
    final todos = List.generate(12, (i) => i + 1);

    // Obtener libros de Firestore
    final db = FirebaseFirestore.instance;
    final snapshot = db
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books')
        .get();

    // Extraer IDs existentes
    final idsOcupados = snapshot.then(
      (snapshot) => snapshot.docs.map((doc) => doc['id'] as int).toList(),
    );

    final Future<int?> getIdsDisponibles = idsOcupados.then((lista) {
      if (lista.isEmpty) {
        return 1;
      }

      if (lista.length == 12) {
        return null;
      } else {
        return todos
            .where((id) {
              bool b = true;
              for (int i = 0; i < lista.length; i++) {
                if (id == lista[i]) {
                  b = false;
                }
              }
              return b;
            })
            .elementAt(0);
      }
    });

    return getIdsDisponibles;
  }

  Future<void> deleteData(Map<String, dynamic> libroData) async {
    final db = FirebaseFirestore.instance;

    final id = libroData['id'];

    final collectionRefLibData = db
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books');
    await collectionRefLibData.doc(id.toString()).delete();
  }
}
