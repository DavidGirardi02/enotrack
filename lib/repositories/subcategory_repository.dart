import '../models/subcategory.dart';
import '../services/subcategory_service.dart';

class SubCategoryRepository {
  final SubCategoryService _service = SubCategoryService();

  List<WineSubCategory> getByCategory(String categoryId) {
    return _service
        .getSubCategories()
        .where((sub) => sub.categoryId == categoryId)
        .toList();
  }
}