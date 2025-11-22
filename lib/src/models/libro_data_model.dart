class LibroData {
  final String id;
  final String autor;
  final String titulo;
  final String estado;
  final String? portada;
  final int? pagLeidas;
  final int? pagTotales;
  final int? tiempoTotal;

  LibroData({
    required this.id,
    this.autor = "anonimo",
    required this.titulo,
    required this.estado,
    this.portada,
    required this.pagTotales,
    this.pagLeidas = 0,
    this.tiempoTotal = 0,
  });

  factory LibroData.fromJson(Map<String, dynamic> libroData) => LibroData(
    id: libroData['id'],
    autor: libroData['autor'],
    titulo: libroData['titulo'],
    estado: libroData['estado'],
    portada: libroData['img_portada'],
    pagLeidas: libroData['pag_leidas'],
    pagTotales: libroData['pag_Totales'],
    tiempoTotal: libroData['tiempo_total'],
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'autor': autor,
      'titulo': titulo,
      'estado': estado,
      'portada': portada,
      'pagLeidas': pagLeidas,
      'pagTotales': pagTotales,
      'tiempoTotal': tiempoTotal,
    };
  }
}
