import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/firestore_wines_provider.dart';
import '../../widgets/wine_card.dart';
import 'wine_detail_screen.dart';
import 'wine_form_screen.dart';

class WineListScreen extends ConsumerStatefulWidget {
  final String categoryId;
  final String? subCategoryId;
  final String title;

  const WineListScreen({
    super.key,
    required this.categoryId,
    this.subCategoryId,
    required this.title,
  });

  @override
  ConsumerState<WineListScreen> createState() =>
      _WineListScreenState();
}

class _WineListScreenState extends ConsumerState<WineListScreen> {
  final searchController = TextEditingController();

  String search = "";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final winesAsync = ref.watch(winesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => WineFormScreen(
                categoryId: widget.categoryId,
                subCategoryId: widget.subCategoryId,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Cerca un vino...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: winesAsync.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),

                error: (err, stack) => Center(
                  child: Text(err.toString()),
                ),

                data: (allWines) {
                  final wines = allWines.where((wine) {
                    final categoryOk =
                        wine.categoriaId == widget.categoryId;

                    final subCategoryOk =
                        widget.subCategoryId == null
                            ? true
                            : wine.sottocategoriaId ==
                                widget.subCategoryId;

                    final searchOk = wine.nome
                        .toLowerCase()
                        .contains(search.toLowerCase());

                    return categoryOk &&
                        subCategoryOk &&
                        searchOk;
                  }).toList();

                  if (wines.isEmpty) {
                    return const Center(
                      child: Text(
                        "Nessun vino trovato",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: wines.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return WineCard(
                        wine: wines[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => WineDetailScreen(
                                wine: wines[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}