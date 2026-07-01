import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/firestore_wines_provider.dart';
import '../dashboard_stat_card.dart';
import '../../screens/reorder/reorder_screen.dart';

class DashboardStatsGrid extends ConsumerWidget {
  const DashboardStatsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winesAsync = ref.watch(winesStreamProvider);

    return winesAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => Center(
        child: Text(error.toString()),
      ),
      data: (wines) {
        final totalWines = wines.length;

        final totalBottles = wines.fold<int>(
          0,
          (sum, wine) => sum + wine.quantita,
        );

        final producers = wines
            .map((wine) => wine.produttore)
            .toSet()
            .length;

        final reorderCount = wines
            .where((wine) => wine.daRiordinare)
            .length;

        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2.2,
          children: [
            DashboardStatCard(
              icon: Icons.wine_bar,
              title: "Vini",
              value: totalWines.toString(),
            ),

            DashboardStatCard(
              icon: Icons.inventory_2_outlined,
              title: "Bottiglie",
              value: totalBottles.toString(),
            ),

            DashboardStatCard(
              icon: Icons.shopping_cart_outlined,
              title: "Da ordinare",
              value: reorderCount.toString(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ReorderScreen(),
                  ),
                );
              },
            ),

            DashboardStatCard(
              icon: Icons.business,
              title: "Produttori",
              value: producers.toString(),
            ),
          ],
        );
      },
    );
  }
}