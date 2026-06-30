import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/wine.dart';
import '../../providers/wine_notifier.dart';
import 'wine_form_screen.dart';

class WineDetailScreen extends ConsumerWidget {
  final Wine wine;

  const WineDetailScreen({
    super.key,
    required this.wine,
  });

  Widget infoTile(String titolo, String valore) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titolo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            valore,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(wine.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  infoTile("Produttore", wine.produttore),
                  infoTile("Annata", wine.annata.toString()),
                  infoTile("Quantità", wine.quantita.toString()),
                  infoTile("Descrizione", wine.descrizione),
                ],
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text("Modifica"),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => WineFormScreen(
                        categoryId: wine.categoriaId,
                        subCategoryId: wine.sottocategoriaId,
                        wine: wine,
                      ),
                    ),
                  );

                  Navigator.pop(context);
                },
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text("Elimina"),
                onPressed: () async {
                  final conferma = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Elimina vino"),
                      content: const Text(
                        "Sei sicuro di voler eliminare questo vino?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text("Annulla"),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text("Elimina"),
                        ),
                      ],
                    ),
                  );

                  if (conferma == true) {
                    ref
                        .read(winesNotifierProvider.notifier)
                        .deleteWine(wine.id);

                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}