import 'package:retolectura/src/models/libro_data_model.dart';

final List<LibroData> librosTest = [
  // Libros sin empezar
  LibroData(
    id: 1,
    autor: 'Gabriel García Márquez',
    titulo: 'Cien años de soledad',
    estado: 'sin empezar',
    portada: 'https://covers.openlibrary.org/b/id/12583699-L.jpg',
    pagTotales: 471,
    pagLeidas: 343,
    tiempoTotal: 0,
  ),
  LibroData(
    id: 2,
    autor: 'Isabel Allende',
    titulo: 'La casa de los espíritus',
    estado: 'sin empezar',
    portada: 'https://covers.openlibrary.org/b/id/8832855-L.jpg',
    pagTotales: 433,
    pagLeidas: 0,
    tiempoTotal: 0,
  ),

  // Libros en progreso
  LibroData(
    id: 3,
    autor: 'Jorge Luis Borges',
    titulo: 'Ficciones',
    estado: 'en progreso',
    portada: 'https://covers.openlibrary.org/b/id/8551111-L.jpg',
    pagTotales: 174,
    pagLeidas: 87,
    tiempoTotal: 5280, // 1h 28min
  ),
  LibroData(
    id: 4,
    autor: 'Julio Cortázar',
    titulo: 'Rayuela',
    estado: 'en progreso',
    portada: 'https://covers.openlibrary.org/b/id/8508597-L.jpg',
    pagTotales: 600,
    pagLeidas: 234,
    tiempoTotal: 14400, // 4 horas
  ),
  LibroData(
    id: 5,
    autor: 'Mario Vargas Llosa',
    titulo: 'La ciudad y los perros',
    estado: 'en progreso',
    portada: 'https://covers.openlibrary.org/b/id/7950347-L.jpg',
    pagTotales: 413,
    pagLeidas: 150,
    tiempoTotal: 9000, // 2h 30min
  ),

  // Libros terminados
  LibroData(
    id: 6,
    autor: 'Pablo Neruda',
    titulo: 'Veinte poemas de amor y una canción desesperada',
    estado: 'terminado',
    portada: 'https://covers.openlibrary.org/b/id/8508617-L.jpg',
    pagTotales: 96,
    pagLeidas: 96,
    tiempoTotal: 7200, // 2 horas
  ),
  LibroData(
    id: 7,
    autor: 'Laura Esquivel',
    titulo: 'Como agua para chocolate',
    estado: 'terminado',
    portada: 'https://covers.openlibrary.org/b/id/8301419-L.jpg',
    pagTotales: 246,
    pagLeidas: 246,
    tiempoTotal: 18000, // 5 horas
  ),
  LibroData(
    id: 8,
    autor: 'Carlos Ruiz Zafón',
    titulo: 'La sombra del viento',
    estado: 'terminado',
    portada: 'https://covers.openlibrary.org/b/id/8508547-L.jpg',
    pagTotales: 565,
    pagLeidas: 565,
    tiempoTotal: 25200, // 7 horas
  ),

  // Libro con autor anónimo
  LibroData(
    id: 9,
    titulo: 'Lazarillo de Tormes',
    estado: 'sin empezar',
    portada: 'https://covers.openlibrary.org/b/id/8505589-L.jpg',
    pagTotales: 128,
    pagLeidas: 0,
    tiempoTotal: 0,
  ),

  // Más variedad
  LibroData(
    id: 10,
    autor: 'Octavio Paz',
    titulo: 'El laberinto de la soledad',
    estado: 'en progreso',
    portada: 'https://covers.openlibrary.org/b/id/8230471-L.jpg',
    pagTotales: 191,
    pagLeidas: 95,
    tiempoTotal: 6300, // 1h 45min
  ),

  LibroData(
    id: 11,
    autor: 'Haruki Murakami',
    titulo: 'Kafka en la orilla',
    estado: 'sin empezar',
    portada: 'https://covers.openlibrary.org/b/id/8339366-L.jpg',
    pagTotales: 505,
    pagLeidas: 0,
    tiempoTotal: 0,
  ),

  LibroData(
    id: 12,
    autor: 'Jane Austen',
    titulo: 'Orgullo y prejuicio',
    estado: 'en progreso',
    portada: 'https://covers.openlibrary.org/b/id/8235156-L.jpg',
    pagTotales: 279,
    pagLeidas: 100,
    tiempoTotal: 7500, // 2h 5min
  ),
];