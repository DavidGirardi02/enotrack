class Wine {
  final String id;
  final String nome;
  final String categoriaId;
  final String sottocategoriaId;
  final String produttore;
  final int annata;
  final int quantita;
  final String descrizione;
  final bool daRiordinare;
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
    required this.daRiordinare,
    this.immagine,
  });

  factory Wine.fromMap(Map<String, dynamic> map, String id) {
    return Wine(
      id: id,
      nome: map["nome"] ?? "",
      categoriaId: map["categoriaId"] ?? "",
      sottocategoriaId: map["sottocategoriaId"] ?? "",
      produttore: map["produttore"] ?? "",
      annata: (map["annata"] ?? 0) as int,
      quantita: (map["quantita"] ?? 0) as int,
      descrizione: map["descrizione"] ?? "",
      daRiordinare: (map["daRiordinare"] as bool?) ?? false,
      immagine: map["immagine"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "nome": nome,
      "categoriaId": categoriaId,
      "sottocategoriaId": sottocategoriaId,
      "produttore": produttore,
      "annata": annata,
      "quantita": quantita,
      "descrizione": descrizione,
      "daRiordinare": daRiordinare,
      "immagine": immagine,
    };
  }

  Wine copyWith({
    String? id,
    String? nome,
    String? categoriaId,
    String? sottocategoriaId,
    String? produttore,
    int? annata,
    int? quantita,
    String? descrizione,
    bool? daRiordinare,
    String? immagine,
  }) {
    return Wine(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      categoriaId: categoriaId ?? this.categoriaId,
      sottocategoriaId: sottocategoriaId ?? this.sottocategoriaId,
      produttore: produttore ?? this.produttore,
      annata: annata ?? this.annata,
      quantita: quantita ?? this.quantita,
      descrizione: descrizione ?? this.descrizione,
      daRiordinare: daRiordinare ?? this.daRiordinare,
      immagine: immagine ?? this.immagine,
    );
  }
}