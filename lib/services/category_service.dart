import '../models/category.dart';

class CategoryService {
  List<WineCategory> getCategories() {
    return const [
      WineCategory(
        id: 'rossi',
        nome: 'Rossi',
        icona: '🍷',
        hasSubCategories: true,
      ),
      WineCategory(
        id: 'bianchi',
        nome: 'Bianchi',
        icona: '🥂',
        hasSubCategories: true,
      ),
      WineCategory(
        id: 'metodo_classico',
        nome: 'Metodo Classico',
        icona: '✨',
        hasSubCategories: false,
      ),
      WineCategory(
        id: 'champagne',
        nome: 'Champagne',
        icona: '🍾',
        hasSubCategories: false,
      ),
      WineCategory(
        id: 'rosati',
        nome: 'Rosati',
        icona: '🌹',
        hasSubCategories: false,
      ),
      WineCategory(
        id: 'dolci',
        nome: 'Dolci',
        icona: '🍇',
        hasSubCategories: false,
      ),
    ];
  }
}