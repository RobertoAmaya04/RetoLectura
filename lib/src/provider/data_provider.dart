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
    final collectionRefTodos = db
        .collection('todos')
        .where('user', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .where('completed', isEqualTo: false)
        .limit(10);

    final snapshotTodos = collectionRefTodos.snapshots();

    final todos = snapshotTodos.map((snapshot) {
      return snapshot.docs.map((todo) {
        return LibroData.fromJson({...todo.data()});
      }).toList();
    });

    return todos;
  }
}
