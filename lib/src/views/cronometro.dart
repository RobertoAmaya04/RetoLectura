import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Para guardar datos localmente
import 'dart:async';
import '../widgets/style_default.dart';


class CronometroScreen extends StatefulWidget {
  @override
  _CronometroScreenState createState() => _CronometroScreenState();
}

class _CronometroScreenState extends State<CronometroScreen> {
  // ===== DATOS DEL LIBRO =====
  TextEditingController tituloController = TextEditingController();
  TextEditingController paginasTotalesController = TextEditingController();
  TextEditingController paginasLeidasController = TextEditingController();

  // ===== CRONÓMETRO =====
  int segundosTranscurridos = 0;           // Tiempo total
  Timer? timer;                            // El Timer que actualiza cada segundo
  DateTime? horaInicio;                    // Se guarda cuando se inició el cronómetro
  bool corriendo = false;                  // Indica si está activo o no

  @override
  void initState() {
    super.initState();
    cargarDatos(); // Cargar datos guardados al abrir la app
  }

  // ===============================
  // CARGAR DATOS DESDE SharedPreferences
  // ===============================
  Future<void> cargarDatos() async { // Obtener instancia de SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Cargar textos
    tituloController.text = prefs.getString("titulo") ?? ""; // Cargar título
    paginasTotalesController.text = prefs.getInt("paginasTotales")?.toString() ?? ""; // Cargar páginas totales
    paginasLeidasController.text = prefs.getInt("paginasLeidas")?.toString() ?? ""; // Cargar páginas leídas

    // Cargar cronómetro
    segundosTranscurridos = prefs.getInt("tiempo") ?? 0;
    corriendo = prefs.getBool("corriendo") ?? false;

    // Cargar hora de inicio
    String? hora = prefs.getString("horaInicio"); // Obtener hora guardada
    if (hora != null) { // Si existe, parsearla
      horaInicio = DateTime.tryParse(hora);
    }

    // Si estaba corriendo, calcular el tiempo real transcurrido
    if (corriendo && horaInicio != null) { // Si estaba corriendo
      Duration diferencia = DateTime.now().difference(horaInicio!); // Calcular diferencia
      segundosTranscurridos += diferencia.inSeconds; // Actualizar segundos transcurridos
      iniciarTimer();
    }

    setState(() {}); // Actualizar la UI
  }

  // ===============================
  // GUARDAR DATOS
  // ===============================
  Future<void> guardarDatos() async { // Obtener instancia de SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("titulo", tituloController.text);  // Guardar título
    prefs.setInt("paginasTotales", int.tryParse(paginasTotalesController.text) ?? 0); // Guardar páginas totales
    prefs.setInt("paginasLeidas", int.tryParse(paginasLeidasController.text) ?? 0); // Guardar páginas leídas

    prefs.setInt("tiempo", segundosTranscurridos); // Guardar tiempo transcurrido
    prefs.setBool("corriendo", corriendo); // Guardar estado del cronómetro

    if (horaInicio != null) { // Si hay hora de inicio, guardarla
      prefs.setString("horaInicio", horaInicio!.toIso8601String()); // Guardar hora de inicio
    }
  }

  // ===============================
  // INICIAR EL CRONÓMETRO
  // ===============================
  void iniciarCronometro() {
    // Si ya está corriendo, no hacemos nada
    if (corriendo) return;

    corriendo = true;
    horaInicio = DateTime.now(); // Guardamos hora real de inicio
    iniciarTimer();
    guardarDatos();
  }

  // Inicia el Timer que actualiza la pantalla cada segundo
  void iniciarTimer() {
    timer = Timer.periodic(  // Guarda un Timer que se ejecuta cada segundo
      const Duration(seconds: 1), // Intervalo de 1 segundo
      (Timer t) {
        setState(() {
          segundosTranscurridos++; // Incrementa el tiempo transcurrido
        });
        guardarDatos();
      },
    );
  }

  // ===============================
  // PAUSAR CRONÓMETRO
  // ===============================
  void pausarCronometro() { // Si ya está pausado, no hacemos nada
    corriendo = false;
    horaInicio = null;

    timer?.cancel();
    guardarDatos();
    setState(() {});
  }

  // ===============================
  // FORMATO DEL TIEMPO
  // ===============================
  String formatoTiempo(int s) { // Convierte segundos a HH:MM:SS
    int horas = s ~/ 3600; // Horas completas
    int minutos = (s % 3600) ~/ 60; // Minutos completos
    int segundos = s % 60; // Segundos restantes

    return "${horas.toString().padLeft(2, '0')}:" // Formato HH:MM:SS
           "${minutos.toString().padLeft(2, '0')}:"
           "${segundos.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) { // Calcular progreso de lectura
    int paginasTotales = int.tryParse(paginasTotalesController.text) ?? 0;
    int paginasLeidas = int.tryParse(paginasLeidasController.text) ?? 0;

    double progreso =
        (paginasTotales > 0) ? (paginasLeidas / paginasTotales) : 0; // Evitar división por cero

    return Scaffold( // Estructura básica de la pantalla
      appBar: AppBar(
        title: const Text("Cronómetro de Lectura"),
        backgroundColor: const Color.fromARGB(255, 28, 239, 106),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: SingleChildScrollView( // Permite hacer scroll si el contenido es muy grande
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ===== TÍTULO DEL LIBRO =====
              const Text("Título del libro:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              /*TextField(
                controller: tituloController,
                onChanged: (_) => guardarDatos(), // Guardar al cambiar el texto
              ),*/
              CustomTextField(
                hintText: "Ingrese el título del libro",
                controller: tituloController,
                keyboardType: TextInputType.text,
                onChanged: (_) => guardarDatos(), // Guardar al cambiar el texto
              ), 

              const SizedBox(height: 20),

              // ===== PAGINAS =====
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Páginas Totales:",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              CustomTextField(hintText:   "Ingrese el total de páginas",
                controller: paginasTotalesController,
                keyboardType: TextInputType.number,
                onChanged: (_) => guardarDatos(),
              ),
              /*TextField(
                controller: paginasTotalesController,
                keyboardType: TextInputType.number,
                onChanged: (_) => guardarDatos(),
              ),*/

              const SizedBox(height: 20),

              const Text("Páginas Leídas:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              CustomTextField(hintText:   "Ingrese las páginas leídas",
                controller: paginasLeidasController,
                keyboardType: TextInputType.number,
                onChanged: (_) {
                int total = int.tryParse(paginasTotalesController.text) ?? 0;
                int leidas = int.tryParse(paginasLeidasController.text) ?? 0;

                //validar que las páginas leídas no superen el total
                if (leidas > total) {
                  paginasLeidasController.text = total.toString();
                  paginasLeidasController.selection = TextSelection.fromPosition(
                    TextPosition(offset: paginasLeidasController.text.length),
                  );
                  leidas = total;
                  };
                guardarDatos();
                setState(() {}); // Actualizar progreso
                },
              ),

              const SizedBox(height: 20),

              // ===== BARRA DE PROGRESO =====
              const Text("Progreso del libro:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: progreso,
                minHeight: 10,
                backgroundColor: Colors.grey[300],
                color: const Color.fromARGB(255, 29, 239, 68),
              ),
              const SizedBox(height: 10),
              Text("${(progreso * 100).toStringAsFixed(1)}% leído"),

              const SizedBox(height: 40),

              // ===== CRONÓMETRO =====
              Center(
                child: Text(
                  formatoTiempo(segundosTranscurridos),
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 30),

              // ===== BOTONES =====
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: iniciarCronometro,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(195, 112, 211, 115),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Iniciar",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: pausarCronometro,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(183, 228, 113, 109),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Pausar",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            SizedBox( //Botón Finalizar lectura, se dejo fuera del row porque ocupa todo el ancho
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  //Navigator.pushNamed(context, '/finalizado'); //Lo deje comentado para que agreguen la ruta al que ir
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(202, 63, 231, 217),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Finalizar lectura",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
