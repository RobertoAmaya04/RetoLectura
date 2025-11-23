import 'package:retolectura/src/models/libro_data_model.dart';

final List<LibroData> librosTest = [
  // Libros sin empezar
  LibroData(
    id: 1,
    autor: 'Gabriel García Márquez',
    titulo: 'Cien años de soledad',
    estado: 'sin empezar',
    portada:
        'https://upload.wikimedia.org/wikipedia/commons/a/a1/Cien_a%C3%B1os_de_soledad.png',
    pagTotales: 471,
    pagLeidas: 343,
    tiempoTotal: 0,
  ),
  LibroData(
    id: 2,
    autor: 'Isabel Allende',
    titulo: 'La casa de los espíritus',
    estado: 'sin empezar',
    portada:
        'https://images.cdn2.buscalibre.com/fit-in/360x360/d5/25/d52503f5d5c793e18a1a1b6d4f8d1e4e.jpg',
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
    portada:
        'https://images.cdn3.buscalibre.com/fit-in/360x360/8f/73/8f73b1a5b5e3b5f5c5d5e5f5g5h5i5j5.jpg',
    pagTotales: 174,
    pagLeidas: 87,
    tiempoTotal: 5280, // 1h 28min
  ),
  LibroData(
    id: 4,
    autor: 'Julio Cortázar',
    titulo: 'Rayuela',
    estado: 'en progreso',
    portada:
        'https://images.cdn1.buscalibre.com/fit-in/360x360/a1/b2/a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6.jpg',
    pagTotales: 600,
    pagLeidas: 234,
    tiempoTotal: 14400, // 4 horas
  ),
  LibroData(
    id: 5,
    autor: 'Mario Vargas Llosa',
    titulo: 'La ciudad y los perros',
    estado: 'en progreso',
    portada:
        'https://images.cdn2.buscalibre.com/fit-in/360x360/q1/w2/q1w2e3r4t5y6u7i8o9p0a1s2d3f4g5h6.jpg',
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
    portada:
        'https://images.cdn3.buscalibre.com/fit-in/360x360/z1/x2/z1x2c3v4b5n6m7k8l9j0h1g2f3d4s5a6.jpg',
    pagTotales: 96,
    pagLeidas: 96,
    tiempoTotal: 7200, // 2 horas
  ),
  LibroData(
    id: 7,
    autor: 'Laura Esquivel',
    titulo: 'Como agua para chocolate',
    estado: 'terminado',
    portada:
        'https://images.cdn1.buscalibre.com/fit-in/360x360/1a/2b/1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p7.jpg',
    pagTotales: 246,
    pagLeidas: 246,
    tiempoTotal: 18000, // 5 horas
  ),
  LibroData(
    id: 8,
    autor: 'Carlos Ruiz Zafón',
    titulo: 'La sombra del viento',
    estado: 'terminado',
    portada:
        'https://images.cdn2.buscalibre.com/fit-in/360x360/q2/w3/q2w3e4r5t6y7u8i9o0p1a2s3d4f5g6h7.jpg',
    pagTotales: 565,
    pagLeidas: 565,
    tiempoTotal: 25200, // 7 horas
  ),

  // Libro con autor anónimo
  LibroData(
    id: 9,
    titulo: 'Lazarillo de Tormes',
    estado: 'sin empezar',
    portada: null,
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
    portada: null,
    pagTotales: 191,
    pagLeidas: 95,
    tiempoTotal: 6300, // 1h 45min
  ),

  LibroData(
    id: 11,
    autor: 'Haruki Murakami',
    titulo: 'Kafka en la orilla',
    estado: 'sin empezar',
    portada:
        'https://images.cdn1.buscalibre.com/fit-in/360x360/9c/81/9c815252443a25f585e5e3d743a2135a.jpg',
    pagTotales: 505,
    pagLeidas: 0,
    tiempoTotal: 0,
  ),

  LibroData(
    id: 12,
    autor: 'Jane Austen',
    titulo: 'Orgullo y prejuicio',
    estado: 'en progreso',
    portada:
        'https://images.cdn2.buscalibre.com/fit-in/360x360/0d/6c/0d6c4da89843a57963e6e8e8e8e8e8e8.jpg',
    pagTotales: 279,
    pagLeidas: 100,
    tiempoTotal: 7500, // 2h 5min
  ),
];
