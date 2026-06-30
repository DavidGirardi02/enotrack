class Wine {
  final String id;
  final String nome;
  final String categoriaId;
  final String sottocategoriaId;
  final String produttore;
  final int annata;
  final int quantita;
  final String descrizione;
  final String? immagine;

  const Wine({
    required this.id,
    required this.nome,
    required this.categoriaId,
    required this.sottocategoriaId,
    required this.produttore,
    required this.annata,
    required this.quantita,
    required this.descrizione,
    this.immagine,
  });

  Wine copyWith({
  String? id,
  String? nome,
  String? categoriaId,
  String? sottocategoriaId,
  String? produttore,
  int? annata,
  int? quantita,
  String? descrizione,
  String? immagine,
}) {
  return Wine(
    id: id ?? this.id,
    nome: nome ?? this.nome,
    categoriaId: categoriaId ?? this.categoriaId,
    sottocategoriaId:
        sottocategoriaId ?? this.sottocategoriaId,
    produttore: produttore ?? this.produttore,
    annata: annata ?? this.annata,
    quantita: quantita ?? this.quantita,
    descrizione: descrizione ?? this.descrizione,
    immagine: immagine ?? this.immagine,
  );
}
}