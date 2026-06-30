import 'package:flutter/material.dart';

import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  final WineCategory category;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(
          category.icona,
          style: const TextStyle(fontSize: 28),
        ),
        title: Text(
          category.nome,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}