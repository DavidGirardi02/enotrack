import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/category.dart';
import '../../providers/category_provider.dart';
import '../../providers/firestore_wines_provider.dart';
import '../../screens/category/category_screen.dart';
import 'section_title.dart';

class CategorySection extends ConsumerWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final winesAsync = ref.watch(winesStreamProvider);

    return winesAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, _) => Center(
        child: Text(error.toString()),
      ),
      data: (wines) {
        int bottlesFor(String categoryId) {
          return wines
              .where((wine) => wine.categoriaId == categoryId)
              .fold(0, (sum, wine) => sum + wine.quantita);
        }

        IconData getIcon(String iconName) {
          switch (iconName) {
            case "wine_bar":
              return Icons.wine_bar;
            case "local_bar":
              return Icons.local_bar;
            case "celebration":
              return Icons.celebration;
            case "local_florist":
              return Icons.local_florist;
            case "liquor":
              return Icons.liquor;
            default:
              return Icons.folder;
          }
        }

        Color getColor(String id) {
          switch (id) {
            case "rossi":
              return const Color(0xFF7B2333);
            case "bianchi":
              return const Color(0xFFC49A3A);
            case "bollicine":
              return const Color(0xFF2F8F62);
            case "rosati":
              return const Color(0xFFD46A8C);
            case "dolci":
              return const Color(0xFFC56C2D);
            default:
              return Colors.grey;
          }
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: "Categorie",
              ),

              const SizedBox(height: 12),

              ...categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 6,
                      ),
                      leading: CircleAvatar(
                        backgroundColor:
                            getColor(category.id).withOpacity(.15),
                        child: Icon(
                          getIcon(category.icona),
                          color: getColor(category.id),
                        ),
                      ),
                      title: Text(
                        category.nome,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "${bottlesFor(category.id)} bottiglie",
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                      ),
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
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}