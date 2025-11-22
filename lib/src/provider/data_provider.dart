import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:retolectura/src/models/libro_data_model.dart';

class LibroDataProvider {
  Future<List<LibroData>> getAllLibroData(String collectionID) async {
    final db = FirebaseFirestore.instance;
    final collectionRefTodos = db.collection(collectionID);

    final snapshotTodos = await collectionRefTodos.get();

    final libroData = List<LibroData>.from(
      snapshotTodos.docs.map((libroData) {
        return LibroData.fromJson({...libroData.data()});
      }),
    );

    return libroData;
  }

  Stream<List<LibroData>> getAllLibroDataStram() {
    final db = FirebaseFirestore.instance;
    final collectionRefLibData = db.collection('libros_data');

    final snapshotLibs = collectionRefLibData.snapshots();

    final lib = snapshotLibs.map((snapshot) {
      return snapshot.docs.map((lib) {
        return LibroData.fromJson({...lib.data()});
      }).toList();
    });

    Future<void> saveData(Map<String, dynamic> libroData) async {
      final db = FirebaseFirestore.instance;

      final collectionRefLibData = db.collection(
        FirebaseAuth.instance.currentUser!.uid,
      );

      await collectionRefLibData.add(libroData);
    }

    return lib;
  }
}
