import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/wine.dart';

class FirestoreWineService {
  final CollectionReference<Map<String, dynamic>> _wines =
      FirebaseFirestore.instance.collection('wines');

  Stream<List<Wine>> watchAll() {
    return _wines.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Wine.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<List<Wine>> getAll() async {
    final snapshot = await _wines.get();

    return snapshot.docs.map((doc) {
      return Wine.fromMap(doc.data(), doc.id);
    }).toList();
  }

  Future<void> addWine(Wine wine) async {
    await _wines.add(wine.toMap());
  }

  Future<void> updateWine(Wine wine) async {
    await _wines.doc(wine.id).update(wine.toMap());
  }

  Future<void> deleteWine(String id) async {
    await _wines.doc(id).delete();
  }
}