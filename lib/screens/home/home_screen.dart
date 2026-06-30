import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/category_provider.dart';
import '../../widgets/category_card.dart';
import '../category/category_screen.dart';
import '../wine/wine_list_screen.dart';
import '../../services/firestore_wine_service.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
        future: FirestoreWineService().getAll(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text("Caricamento...");
          }

          return Text(
            "🍷 ${snapshot.data!.length} vini",
          );
        },
      ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CategoryCard(
              category: category,
              onTap: () {
                if (category.hasSubCategories) {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CategoryScreen(
                        category: category,
                        ),
                    ),
                    );
                } else {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => WineListScreen(
                            categoryId: category.id,
                            title: category.nome,
                        )
                    ),
                    );
                }
                },
            ),
          );
        },
      ),
    );
  }
}