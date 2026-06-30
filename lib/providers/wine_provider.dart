import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/wine.dart';
import '../repositories/wine_repository.dart';

final wineRepositoryProvider =
    Provider((ref) => WineRepository());

final winesProvider =
    Provider.family<List<Wine>, String>((ref, subCategoryId) {
  return ref
      .read(wineRepositoryProvider)
      .getBySubCategory(subCategoryId);
});