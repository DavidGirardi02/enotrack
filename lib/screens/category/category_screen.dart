import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/category.dart';
import '../../providers/subcategory_provider.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text(category.nome),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: subCategories.length,
        itemBuilder: (context, index) {
          final sub = subCategories[index];

          return Card(
            child: ListTile(
              title: Text(sub.nome),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (_) => WineListScreen(
                        categoryId: category.id,
                        subCategoryId: sub.id,
                        title: sub.nome,
                        )
                    ),
                );
                },
            ),
          );
        },
      ),
    );
  }
}