import '../models/wine.dart';
import '../services/firestore_wine_service.dart';

class FirestoreWineRepository {
  final FirestoreWineService _service = FirestoreWineService();

  Future<List<Wine>> getAll() {
    return _service.getAll();
  }
}