import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/firestore_wines_provider.dart';

class ReorderScreen extends ConsumerWidget {
  const ReorderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winesAsync = ref.watch(winesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Da riordinare"),
      ),
      body: winesAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),

        error: (e, _) => Center(
          child: Text(e.toString()),
        ),

        data: (wines) {
          final reorder =
              wines.where((wine) => wine.daRiordinare).toList();

          if (reorder.isEmpty) {
            return const Center(
              child: Text(
                "Nessun vino da riordinare 🍷",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: reorder.length,
            itemBuilder: (context, index) {
              final wine = reorder[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: CheckboxListTile(
                  value: wine.daRiordinare,
                  title: Text(
                    wine.nome,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${wine.produttore} • ${wine.annata}",
                  ),
                  onChanged: (value) async {
                    await ref
                        .read(firestoreWineServiceProvider)
                        .updateWine(
                          wine.copyWith(
                            daRiordinare: value ?? false,
                          ),
                        );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}