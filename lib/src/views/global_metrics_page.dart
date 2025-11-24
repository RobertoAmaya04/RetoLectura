import 'package:flutter/material.dart';

import 'package:retolectura/src/models/libro_data_model.dart';
import 'package:retolectura/src/provider/data_provider.dart';

class GlobalMetricsPage extends StatelessWidget {
  const GlobalMetricsPage({super.key, required this.books});
  final List<LibroData> books;
  // ignore: prefer_function_declarations_over_variables

  String _formatDuration(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${hours}h ${minutes}m ${seconds}s';
  }

  @override
  Widget build(BuildContext context) {
    var totalTime = 0;
    var totalPagesRead = 0;
    var totalPages = 0;

    for (final b in books) {
      totalTime += b.tiempoTotal;
      totalPagesRead += b.pagLeidas;
      totalPages += b.pagTotales;
    }

    final formattedTime = _formatDuration(totalTime);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Métricas Globales',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6A1B9A), // Deep Purple
              Color(0xFF9C27B0), // Purple
              Color(0xFFE040FB), // Bright Purple/Fuchsia
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: kToolbarHeight + 40),
              const Text(
                'Resumen de Lectura',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      icon: Icons.timer,
                      title: 'Tiempo Total de Lectura',
                      value: formattedTime,
                      color: const Color(0xFFE040FB),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildMetricCard(
                      icon: Icons.menu_book,
                      title: 'Progreso Total de Páginas',
                      value: '$totalPagesRead / $totalPages',
                      color: const Color(0xFFE040FB),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Tus Libros',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return Card(
                      color: Colors.white.withValues(alpha: 0.2),
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SizedBox(
                        width: 120,
                        height: 180,
                        child: book.portada != null
                            ? Image.network(
                                book.portada!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      color: Colors.white.withValues(
                                        alpha: 0.1,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.book,
                                          size: 80,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ),
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        color: Colors.white.withValues(
                                          alpha: 0.1,
                                        ),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            value:
                                                loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                : null,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      );
                                    },
                              )
                            : Container(
                                color: Colors.white.withValues(alpha: 0.1),
                                child: const Center(
                                  child: Icon(
                                    Icons.book,
                                    size: 80,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white.withValues(alpha: 0.2),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 36),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
