import '../models/category.dart';
import '../services/category_service.dart';

class CategoryRepository {
  final CategoryService _service = CategoryService();

  List<WineCategory> getCategories() {
    return _service.getCategories();
  }
}