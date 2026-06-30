import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/category_provider.dart';
import '../../widgets/category_card.dart';
import '../category/category_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("🍷 Cantina Manager"),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (_) => CategoryScreen(
                        category: category,
                    ),
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