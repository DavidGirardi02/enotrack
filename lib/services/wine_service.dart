import '../models/wine.dart';

class WineService {
  final List<Wine> _wines = [
    const Wine(
      id: '1',
      nome: 'Amarone della Valpolicella',
      categoriaId: 'rossi',
      sottocategoriaId: 'italiani',
      produttore: 'Allegrini',
      annata: 2020,
      quantita: 12,
      descrizione: 'Rosso corposo con note di ciliegia e cacao.',
    ),
    const Wine(
      id: '2',
      nome: 'Barolo',
      categoriaId: 'rossi',
      sottocategoriaId: 'italiani',
      produttore: 'Gaja',
      annata: 2019,
      quantita: 8,
      descrizione: 'Elegante e strutturato.',
    ),
    const Wine(
      id: '3',
      nome: 'Chablis',
      categoriaId: 'bianchi',
      sottocategoriaId: 'francesi_bianchi',
      produttore: 'Louis Jadot',
      annata: 2022,
      quantita: 15,
      descrizione: 'Minerale e fresco.',
    ),
  ];

  List<Wine> getAll() {
    return _wines;
  }

  void add(Wine wine) {
    _wines.add(wine);
  }

  void update(Wine wine) {
    final index = _wines.indexWhere(
      (element) => element.id == wine.id,
    );

    if (index != -1) {
      _wines[index] = wine;
    }
  }

  void delete(String id) {
    _wines.removeWhere(
      (wine) => wine.id == id,
    );
  }
}