import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/subcategory.dart';
import '../repositories/subcategory_repository.dart';

final subCategoryRepositoryProvider =
    Provider((ref) => SubCategoryRepository());

final subCategoriesProvider =
    Provider.family<List<WineSubCategory>, String>((ref, categoryId) {
  return ref
      .read(subCategoryRepositoryProvider)
      .getByCategory(categoryId);
});