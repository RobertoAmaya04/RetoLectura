import 'dart:async';
import 'package:flutter/material.dart';

class CronometroScreen extends StatefulWidget { //Declaración de la pantalla del cronómetro
  @override
  _CronometroScreenState createState() => _CronometroScreenState();
}

class _CronometroScreenState extends State<CronometroScreen> { //Estado del cronómetro
  Timer? _timer; //Objeto que realiza el conteo del tiempo
  int _seconds = 0; //Contador de segundos
  bool _isRunning = false; //Estado del cronómetro (en ejecución o pausado) para evitar que se realice múltiples timers

  void _startTimer() { //Función para iniciar el cronómetro
    if (_isRunning) return;
    _isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) { //El timer.periodic ejecuta una función cada cierto tiempo
      setState(() {
        _seconds++;
      });
    });
  }

  void _pauseTimer() { //Función para pausar el cronómetro
    _timer?.cancel();
    _isRunning = false;
  }

  void _resetTimer() { //Función para reiniciar el cronómetro
    _timer?.cancel();
    setState(() {
      _seconds = 0;
      _isRunning = false;
    });
  }

  String _formatTime(int seconds) { //Función para formatear el tiempo en minutos y segundos
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  Widget build(BuildContext context) { //Construcción de la interfaz de usuario
    return Scaffold(
      appBar: AppBar(title: Text('Cronómetro de lectura')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatTime(_seconds),
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _startTimer, child: Text('Iniciar')),
                SizedBox(width: 10),
                ElevatedButton(onPressed: _pauseTimer, child: Text('Pausar')),
                SizedBox(width: 10),
                ElevatedButton(onPressed: _resetTimer, child: Text('Reiniciar')),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() { //Limpieza del timer al cerrar la pantalla
    _timer?.cancel();
    super.dispose();
  }
}
