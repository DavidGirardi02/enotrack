import 'package:flutter/material.dart';

import '../models/wine.dart';

class WineCard extends StatelessWidget {
  final Wine wine;
  final VoidCallback onTap;

  const WineCard({
    super.key,
    required this.wine,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(
          wine.nome,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${wine.produttore} • ${wine.annata}",
        ),
        trailing: Chip(
          label: Text("${wine.quantita}"),
        ),
        onTap: onTap,
      ),
    );
  }
}