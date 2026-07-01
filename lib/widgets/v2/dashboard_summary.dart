import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/firestore_wines_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../screens/reorder_screen.dart';

class DashboardSummary extends ConsumerWidget {
  const DashboardSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winesAsync = ref.watch(winesStreamProvider);

    return winesAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, _) => Text(e.toString()),
      data: (wines) {
        final totalWines = wines.length;

        final totalBottles =
            wines.fold<int>(0, (sum, wine) => sum + wine.quantita);

        final producers =
            wines.map((e) => e.produttore).toSet().length;

        final reorder =
            wines.where((e) => e.daRiordinare).length;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 18,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Riepilogo",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: _Item(
                      Icons.wine_bar,
                      "Vini",
                      totalWines.toString(),
                    ),
                  ),
                  Expanded(
                    child: _Item(
                      Icons.inventory_2_outlined,
                      "Bottiglie",
                      totalBottles.toString(),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _Item(
                      Icons.business,
                      "Produttori",
                      producers.toString(),
                    ),
                  ),
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(18),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ReorderScreen(),
                            ),
                          );
                        },
                        child: _Item(
                          Icons.shopping_cart_outlined,
                          "Riordino",
                          reorder.toString(),
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color? color;

  const _Item(
    this.icon,
    this.title,
    this.value, {
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: (color ?? AppColors.primary).withOpacity(.12),
          child: Icon(
            icon,
            color: color ?? AppColors.primary,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),

        if (title == "Riordino")
          const Icon(
            Icons.chevron_right_rounded,
            size: 26,
            color: Colors.grey,
          ),
      ],
    );
  }
}