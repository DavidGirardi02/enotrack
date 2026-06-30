import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/wine_provider.dart';
import '../../widgets/wine_card.dart';
import 'wine_detail_screen.dart';
import 'wine_form_screen.dart';

class WineListScreen extends ConsumerWidget {
  final String subCategoryId;
  final String title;

  const WineListScreen({
    super.key,
    required this.subCategoryId,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wines = ref.watch(
      winesProvider(subCategoryId),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),

    floatingActionButton: FloatingActionButton(
        onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const WineFormScreen(),
            ),
            );
        },
        child: const Icon(Icons.add),
        ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: wines.length,
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
      ),
    );
  }
}