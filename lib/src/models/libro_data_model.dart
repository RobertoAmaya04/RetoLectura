class LibroData {
  final int? id;
  final String autor;
  final String titulo;
  final String estado;
  final String portada;
  final int pagLeidas;
  final int pagTotales;
  final int tiempoTotal;

  LibroData({
    this.id,
    required this.autor,
    required this.titulo,
    this.portada =
        "https://images.icon-icons.com/317/PNG/512/book-bookmark-icon_34486.png",
    required this.pagTotales,
    required this.pagLeidas,
    required this.tiempoTotal,
    required this.estado,
  });

  factory LibroData.fromJson(Map<String, dynamic> libroData) => LibroData(
    id: libroData['id'],
    autor: libroData['autor'],
    titulo: libroData['titulo'],
    estado: libroData['estado'],
    portada: libroData['img_portada'],
    pagLeidas: libroData['pag_leidas'],
    pagTotales: libroData['pag_totales'],
    tiempoTotal: libroData['tiempo_total'],
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'autor': autor,
      'titulo': titulo,
      'estado': estado,
      'img_portada': portada,
      'pag_leidas': pagLeidas,
      'pag_totales': pagTotales,
      'tiempo_total': tiempoTotal,
    };
  }
}
