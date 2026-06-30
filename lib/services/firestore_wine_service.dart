import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/wine.dart';

class FirestoreWineService {
  final _db = FirebaseFirestore.instance;

  Future<List<Wine>> getAll() async {
    final snapshot = await _db.collection('wines').get();

    return snapshot.docs.map((doc) {
      return Wine.fromMap(doc.data(), doc.id);
    }).toList();
  }
}