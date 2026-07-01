import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../models/wine.dart';
import '../../providers/firestore_wines_provider.dart';

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

  bool daRiordinare = false;

  @override
  void initState() {
    super.initState();

    if (widget.wine != null) {
      nomeController.text = widget.wine!.nome;
      produttoreController.text = widget.wine!.produttore;
      annataController.text = widget.wine!.annata.toString();
      quantitaController.text = widget.wine!.quantita.toString();
      descrizioneController.text = widget.wine!.descrizione;
      daRiordinare = widget.wine!.daRiordinare;
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    produttoreController.dispose();
    annataController.dispose();
    quantitaController.dispose();
    descrizioneController.dispose();
    super.dispose();
  }

  Future<void> salva() async {
    if (!_formKey.currentState!.validate()) return;

    final wine = Wine(
      id: widget.wine?.id ?? const Uuid().v4(),
      nome: nomeController.text.trim(),
      categoriaId: widget.categoryId,
      sottocategoriaId: widget.subCategoryId ?? widget.categoryId,
      produttore: produttoreController.text.trim(),
      annata: int.parse(annataController.text),
      quantita: int.parse(quantitaController.text),
      descrizione: descrizioneController.text.trim(),
      daRiordinare: widget.wine?.daRiordinare ?? false,
    );

    final service = ref.read(firestoreWineServiceProvider);

    if (widget.wine == null) {
      await service.addWine(wine);
    } else {
      await service.updateWine(wine);
    }

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  InputDecoration decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.wine != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          editing ? "Modifica vino" : "Nuovo vino",
        ),
        centerTitle: false,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: nomeController,
              decoration: decoration(
                "Nome vino",
                Icons.wine_bar,
              ),
              validator: (value) =>
                  value == null || value.isEmpty
                      ? "Inserisci il nome"
                      : null,
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: produttoreController,
              decoration: decoration(
                "Produttore",
                Icons.business,
              ),
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: annataController,
                    keyboardType: TextInputType.number,
                    decoration: decoration(
                      "Annata",
                      Icons.calendar_today,
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty
                            ? "Obbligatorio"
                            : null,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: TextFormField(
                    controller: quantitaController,
                    keyboardType: TextInputType.number,
                    decoration: decoration(
                      "Quantità",
                      Icons.inventory_2,
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty
                            ? "Obbligatorio"
                            : null,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: descrizioneController,
              maxLines: 5,
              decoration: decoration(
                "Descrizione",
                Icons.notes,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: salva,
                icon: const Icon(Icons.save),
                label: Text(
                  editing ? "Salva modifiche" : "Aggiungi vino",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}