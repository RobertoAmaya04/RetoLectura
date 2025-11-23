import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:retolectura/src/models/libro_data_model.dart';
import 'package:retolectura/src/provider/data_provider.dart';

class CronometroScreen extends StatefulWidget {
  final LibroData libro;

  const CronometroScreen({super.key, required this.libro});
  @override
  _CronometroScreenState createState() => _CronometroScreenState();
}

class _CronometroScreenState extends State<CronometroScreen> {
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;
  bool _isPaused = false;
  bool _hasSaved = false;
  int totalTime = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (_isRunning) return;
    _isRunning = true;
    _isPaused = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _pauseTimer() {
    if (_isRunning && !_isPaused) {
      _timer?.cancel();
      _isPaused = true;
      setState(() {});
    }
  }

  void _resumeTimer() {
    // Re-instanciamos el timer para continuar.
    if (_isRunning && _isPaused) {
      _isPaused = false;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });
      setState(() {});
    }
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = 0;
      _isRunning = false;
      _isPaused = false;
      _hasSaved = false;
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  Future<bool> _showExitConfirmationDialog() async {
    if (_seconds == 0 || _hasSaved) {
      return true;
    }

    _pauseTimer();
    final pageController = TextEditingController();

    return (await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Guardar Progreso'),
            content: TextField(
              controller: pageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '¿En qué página quedaste?',
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _resumeTimer();
                  context.pop(false);
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  LibroDataProvider().updateData({
                    'id': widget.libro.id,
                    'pag_leidas':
                        ((int.tryParse(pageController.text) ??
                                widget.libro.pagLeidas) <=
                            widget.libro.pagTotales)
                        ? (int.tryParse(pageController.text) ??
                              widget.libro.pagLeidas)
                        : widget.libro.pagLeidas,
                  });
                  if (totalTime == 0) {
                    totalTime = widget.libro.pagLeidas;
                  }

                  totalTime += _seconds;
                  // Aquí deberías tener una función para actualizar el libro en tu DataProvider
                  // provider.updateBook(updatedLibro);

                  setState(() {
                    _hasSaved = true;
                  });

                  context.pop(true);
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        LibroDataProvider().updateData({
          'id': widget.libro.id,
          'tiempo_total': totalTime,
        });
        final canPop = await _showExitConfirmationDialog();
        if (canPop) {
          context.pop();
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cronómetro de lectura'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A1B9A), Color(0xFF9C27B0), Color(0xFFE040FB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _formatTime(_seconds),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildButtons(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildButtons() {
    if (!_isRunning) {
      return [
        ElevatedButton(
          onPressed: _startTimer,
          child: const Text('Iniciar'),
          style: _buttonStyle(),
        ),
      ];
    }

    if (_hasSaved) {
      return [
        ElevatedButton(
          onPressed: _resetTimer,
          child: const Text('Reiniciar'),
          style: _buttonStyle(color: Colors.orange),
        ),
      ];
    }

    return [
      ElevatedButton( 
        onPressed: _isPaused ? _resumeTimer : _pauseTimer,
        child: Text(_isPaused ? 'Continuar' : 'Pausar'),
        style: _buttonStyle(color: _isPaused ? Colors.green : null),
      ),
      const SizedBox(width: 10),
      ElevatedButton(
        onPressed: _showExitConfirmationDialog,
        child: const Text('Finalizar'),
        style: _buttonStyle(),
      ),
    ];
  }

  ButtonStyle _buttonStyle({Color? color}) { 
    return ElevatedButton.styleFrom(
      foregroundColor: color ?? const Color(0xFF6A1B9A),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
