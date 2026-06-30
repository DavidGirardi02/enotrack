import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/category.dart';
import '../repositories/category_repository.dart';

final categoryRepositoryProvider =
    Provider<CategoryRepository>((ref) {
  return CategoryRepository();
});

final categoriesProvider =
    Provider<List<WineCategory>>((ref) {
  return ref.read(categoryRepositoryProvider).getCategories();
});