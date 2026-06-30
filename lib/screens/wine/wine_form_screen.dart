import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../models/wine.dart';
import '../../providers/wine_provider.dart';
import '../../providers/wine_notifier.dart';

class WineFormScreen extends ConsumerStatefulWidget {
  final String categoryId;
  final String? subCategoryId;

final Wine? wine;

    const WineFormScreen({
        super.key,
        required this.categoryId,
        this.subCategoryId,
        this.wine,
    });

  @override
  ConsumerState<WineFormScreen> createState() => _WineFormScreenState();
}

class _WineFormScreenState extends ConsumerState<WineFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final produttoreController = TextEditingController();
  final annataController = TextEditingController();
  final quantitaController = TextEditingController();
  final descrizioneController = TextEditingController();

  @override
    void initState() {
    super.initState();

    if (widget.wine != null) {
        nomeController.text = widget.wine!.nome;
        produttoreController.text = widget.wine!.produttore;
        annataController.text = widget.wine!.annata.toString();
        quantitaController.text = widget.wine!.quantita.toString();
        descrizioneController.text = widget.wine!.descrizione;
    }
    }
  void dispose() {
    nomeController.dispose();
    produttoreController.dispose();
    annataController.dispose();
    quantitaController.dispose();
    descrizioneController.dispose();
    super.dispose();
  }

  void salva() {
    if (!_formKey.currentState!.validate()) return;

    final wine = Wine(
      id: widget.wine?.id ?? Uuid().v4(),
      nome: nomeController.text.trim(),
      categoriaId: widget.categoryId,
      sottocategoriaId: widget.subCategoryId ?? widget.categoryId,
      produttore: produttoreController.text.trim(),
      annata: int.parse(annataController.text),
      quantita: int.parse(quantitaController.text),
      descrizione: descrizioneController.text.trim(),
    );

    if (widget.wine == null) {
        ref.read(winesNotifierProvider.notifier).addWine(wine);
    } else {
        ref.read(winesNotifierProvider.notifier).updateWine(wine);
    }

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.wine == null ? "Nuovo vino" : "Modifica vino",
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: "Nome",
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? "Obbligatorio" : null,
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: produttoreController,
              decoration: const InputDecoration(
                labelText: "Produttore",
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: annataController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Annata",
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? "Obbligatorio" : null,
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: quantitaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Quantità",
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? "Obbligatorio" : null,
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: descrizioneController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Descrizione",
              ),
            ),

            const SizedBox(height: 24),

            FilledButton.icon(
              onPressed: salva,
              icon: const Icon(Icons.save),
              label: const Text("Salva"),
            ),
          ],
        ),
      ),
    );
  }
}