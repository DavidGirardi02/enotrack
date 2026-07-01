import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/wine.dart';
import '../../providers/firestore_wines_provider.dart';
import '../../screens/wine/wine_detail_screen.dart';

class GlobalSearchBar extends ConsumerWidget {
  const GlobalSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winesAsync = ref.watch(winesStreamProvider);

    return winesAsync.when(
      loading: () => const SizedBox(
        height: 52,
        child: Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),

      error: (_, __) => const SizedBox(),

      data: (wines) {
        return SearchAnchor.bar(
          barHintText: "Cerca un vino...",
          barLeading: const Icon(Icons.search),

          suggestionsBuilder: (context, controller) {
            final query = controller.text.trim().toLowerCase();

            if (query.isEmpty) {
              return [
                const ListTile(
                  leading: Icon(Icons.search),
                  title: Text("Inizia a digitare..."),
                ),
              ];
            }

            final results = wines.where((wine) {
              return wine.nome.toLowerCase().contains(query) ||
                  wine.produttore.toLowerCase().contains(query) ||
                  wine.descrizione.toLowerCase().contains(query) ||
                  wine.annata.toString().contains(query) ||
                  wine.categoriaId.toLowerCase().contains(query);
            }).take(10);

            return results.map(
              (Wine wine) => ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.wine_bar),
                ),
                title: Text(wine.nome),
                subtitle: Text(
                  "${wine.produttore} • ${wine.annata}",
                ),
                trailing: Text(
                  "${wine.quantita}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  controller.closeView("");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WineDetailScreen(
                        wine: wine,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}