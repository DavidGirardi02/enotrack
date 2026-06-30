import '../models/category.dart';

class CategoryService {
  List<WineCategory> getCategories() {
    return const [
      WineCategory(
        id: 'rossi',
        nome: 'Rossi',
        icona: '🍷',
      ),
      WineCategory(
        id: 'bianchi',
        nome: 'Bianchi',
        icona: '🥂',
      ),
      WineCategory(
        id: 'metodo_classico',
        nome: 'Metodo Classico',
        icona: '✨',
      ),
      WineCategory(
        id: 'champagne',
        nome: 'Champagne',
        icona: '🍾',
      ),
    ];
  }
}