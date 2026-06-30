import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/wine.dart';
import 'wine_provider.dart';

class WineNotifier extends Notifier<List<Wine>> {
  @override
  List<Wine> build() {
    return ref.read(wineRepositoryProvider).getAll();
  }

  void addWine(Wine wine) {
    ref.read(wineRepositoryProvider).add(wine);

    state = [
      ...ref.read(wineRepositoryProvider).getAll(),
    ];
  }

  void updateWine(Wine wine) {
    ref.read(wineRepositoryProvider).update(wine);

    state = [
      ...ref.read(wineRepositoryProvider).getAll(),
    ];
  }

  void deleteWine(String id) {
    ref.read(wineRepositoryProvider).delete(id);

    state = [
      ...ref.read(wineRepositoryProvider).getAll(),
    ];
  }
}

final winesNotifierProvider =
    NotifierProvider<WineNotifier, List<Wine>>(
  WineNotifier.new,
);