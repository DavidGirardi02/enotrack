import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/wine_provider.dart';
import '../../widgets/wine_card.dart';

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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: wines.length,
        itemBuilder: (context, index) {
          return WineCard(
            wine: wines[index],
            onTap: () {
              debugPrint(wines[index].nome);
            },
          );
        },
      ),
    );
  }
}