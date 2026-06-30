import '../models/wine.dart';
import '../services/wine_service.dart';

class WineRepository {
  final WineService _service = WineService();

  List<Wine> getAll() {
    return _service.getAll();
  }

  List<Wine> getBySubCategory(String subCategoryId) {
    return _service
        .getAll()
        .where((wine) => wine.sottocategoriaId == subCategoryId)
        .toList();
  }

  void add(Wine wine) {
    _service.add(wine);
  }

  void update(Wine wine) {
    _service.update(wine);
  }

  void delete(String id) {
    _service.delete(id);
  }
}