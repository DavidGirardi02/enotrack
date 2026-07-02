import '../models/subcategory.dart';

class SubCategoryService {
  List<WineSubCategory> getSubCategories() {
    return const [

      // Rossi
      WineSubCategory(
        id: 'italiani',
        nome: 'Italiani',
        categoryId: 'rossi',
      ),
      WineSubCategory(
        id: 'francesi',
        nome: 'Francesi',
        categoryId: 'rossi',
      ),

      // Bianchi
      WineSubCategory(
        id: 'italiani_bianchi',
        nome: 'Italiani',
        categoryId: 'bianchi',
      ),
      WineSubCategory(
        id: 'francesi_bianchi',
        nome: 'Francesi',
        categoryId: 'bianchi',
      ),
    ];
  }
}