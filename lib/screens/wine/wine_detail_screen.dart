import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/wine.dart';
import '../../providers/firestore_wines_provider.dart';
import 'wine_form_screen.dart';

class WineDetailScreen extends ConsumerStatefulWidget {
  final Wine wine;

  const WineDetailScreen({
    super.key,
    required this.wine,
  });

  @override
  ConsumerState<WineDetailScreen> createState() =>
      _WineDetailScreenState();
}

class _WineDetailScreenState
    extends ConsumerState<WineDetailScreen> {

  late bool daRiordinare;

  @override
  void initState() {
    super.initState();
    daRiordinare = widget.wine.daRiordinare;
  }

  Future<void> aggiornaRiordino(bool value) async {
    setState(() {
      daRiordinare = value;
    });

    await ref
        .read(firestoreWineServiceProvider)
        .updateWine(
          widget.wine.copyWith(
            daRiordinare: value,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final wine = widget.wine;

    return Scaffold(
      appBar: AppBar(
        title: Text(wine.nome),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [

                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(.12),
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.wine_bar,
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
                      size: 32,
                    ),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          wine.nome,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          wine.produttore,
                          style: TextStyle(
                            color:
                                Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Card(
            child: SwitchListTile(
              secondary: const Icon(
                Icons.shopping_cart_outlined,
              ),
              title: const Text(
                "Da riordinare",
              ),
              subtitle: const Text(
                "Comparirà nella lista riordino",
              ),
              value: daRiordinare,
              onChanged: aggiornaRiordino,
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [

                  _InfoRow(
                    label: "Annata",
                    value: wine.annata.toString(),
                  ),

                  const Divider(),

                  _InfoRow(
                    label: "Quantità",
                    value:
                        "${wine.quantita} bottiglie",
                  ),

                  const Divider(),

                  _InfoRow(
                    label: "Produttore",
                    value: wine.produttore,
                  ),
                ],
              ),
            ),
          ),

          if (wine.descrizione.isNotEmpty) ...[

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Descrizione",
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      wine.descrizione,
                    ),
                  ],
                ),
              ),
            ),
          ],

          const SizedBox(height: 30),

          FilledButton.icon(
            icon: const Icon(Icons.edit),
            label: const Text("Modifica"),
            onPressed: () async {

              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => WineFormScreen(
                    categoryId: wine.categoriaId,
                    subCategoryId:
                        wine.sottocategoriaId,
                    wine: wine,
                  ),
                ),
              );

              if (mounted) {
                Navigator.pop(context);
              }
            },
          ),

          const SizedBox(height: 12),

          OutlinedButton.icon(
            icon: const Icon(Icons.delete),
            label: const Text("Elimina"),
            onPressed: () async {

              final conferma =
                  await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title:
                      const Text("Elimina vino"),
                  content: const Text(
                    "Sei sicuro di voler eliminare questo vino?",
                  ),
                  actions: [

                    TextButton(
                      onPressed: () =>
                          Navigator.pop(
                              context, false),
                      child:
                          const Text("Annulla"),
                    ),

                    FilledButton(
                      onPressed: () =>
                          Navigator.pop(
                              context, true),
                      child:
                          const Text("Elimina"),
                    ),
                  ],
                ),
              );

              if (conferma == true) {

                await ref
                    .read(
                        firestoreWineServiceProvider)
                    .deleteWine(wine.id);

                if (mounted) {
                  Navigator.pop(context);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}