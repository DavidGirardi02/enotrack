import 'package:flutter/material.dart';

import '../../models/wine.dart';

class WineDetailScreen extends StatelessWidget {
  final Wine wine;

  const WineDetailScreen({
    super.key,
    required this.wine,
  });

  Widget infoTile(String titolo, String valore) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titolo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            valore,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(wine.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [

            infoTile("Produttore", wine.produttore),

            infoTile("Annata", wine.annata.toString()),

            infoTile("Quantità", wine.quantita.toString()),

            infoTile("Descrizione", wine.descrizione),

          ],
        ),
      ),
    );
  }
}