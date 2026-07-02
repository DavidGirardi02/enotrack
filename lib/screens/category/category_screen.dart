import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/category.dart';
import '../../providers/subcategory_provider.dart';
import '../../widgets/v2/subcategory_tile.dart';
import '../wine/wine_list_screen.dart';

class CategoryScreen extends ConsumerWidget {
  final WineCategory category;

  const CategoryScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subCategories = ref.watch(
      subCategoriesProvider(category.id),
    );

    if (subCategories.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => WineListScreen(
              categoryId: category.id,
              title: category.nome,
            ),
          ),
        );
      });

      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(category.nome),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Scegli una sottocategoria",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.separated(
                itemCount: subCategories.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final sub = subCategories[index];

                  return SubCategoryTile(
                    title: sub.nome,
                    onTap: () {
                      print("Apro ${sub.nome}");

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WineListScreen(
                            categoryId: category.id,
                            subCategoryId: sub.id,
                            title: sub.nome,
                          ),
                        ),
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