import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:retolectura/src/models/libro_data_model.dart';

class LibroDataProvider {
  Future<List<LibroData>> getAllLibroData() async {
    final db = FirebaseFirestore.instance;
    final collectionRefTodos = db.collection('users');

    final snapshotTodos = await collectionRefTodos.get();

    final libroData = List<LibroData>.from(
      snapshotTodos.docs.map((libroData) {
        return LibroData.fromJson({...libroData.data()});
      }),
    );

    return libroData;
  }

  Stream<List<LibroData>> getAllLibroDataStream() {
    final db = FirebaseFirestore.instance;
    final collectionRefLibData = db
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books');

    final snapshotLibs = collectionRefLibData.snapshots();

    final lib = snapshotLibs.map((snapshot) {
      return snapshot.docs.map((lib) {
        return LibroData.fromJson({...lib.data()});
      }).toList();
    });

    return lib;
  }

  Future<void> saveData(Map<String, dynamic> libroData, String docID) async {
    final db = FirebaseFirestore.instance;

    final collectionRefLibData = db
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books');

    await collectionRefLibData.doc('docID').set(libroData);
  }

  Future<void> updateData(Map<String, dynamic> libroData, String docID) async {
    final db = FirebaseFirestore.instance;

    final collectionRefLibData = db
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('books');
    await collectionRefLibData.doc(docID).update(libroData);
  }
}
