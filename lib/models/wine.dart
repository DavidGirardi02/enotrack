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
}