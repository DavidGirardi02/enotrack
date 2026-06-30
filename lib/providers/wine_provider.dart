import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/wine_repository.dart';
import '../services/wine_service.dart';

final wineServiceProvider = Provider<WineService>((ref) {
  return WineService();
});

final wineRepositoryProvider = Provider<WineRepository>((ref) {
  return WineRepository(ref.read(wineServiceProvider));
});