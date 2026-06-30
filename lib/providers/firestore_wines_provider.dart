import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/wine.dart';
import '../services/firestore_wine_service.dart';

final firestoreWineServiceProvider =
    Provider<FirestoreWineService>((ref) {
  return FirestoreWineService();
});

final winesStreamProvider =
    StreamProvider<List<Wine>>((ref) {
  return ref
      .read(firestoreWineServiceProvider)
      .watchAll();
});