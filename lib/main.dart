import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:retolectura/firebase_options.dart';
import 'package:retolectura/src/models/fakeData.dart';
import 'package:retolectura/src/models/libro_data_model.dart';
import 'package:retolectura/src/views/cronometro.dart';
import 'package:retolectura/src/views/global_metrics_page.dart';
import 'package:retolectura/src/views/libro_estadisticas.dart';
import 'package:retolectura/src/views/login_page.dart';
import 'package:retolectura/src/views/manage_book_page.dart';
import 'package:retolectura/src/provider/data_provider.dart';
import 'package:retolectura/src/services/google-signIn.dart';
import 'package:go_router/go_router.dart';
import 'package:retolectura/src/views/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const RetoLectura());
}

class RetoLectura extends StatelessWidget {
  const RetoLectura({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Reto Lectura',
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouter(
        initialLocation: '/home',
        routes: [
          GoRoute(
            path: '/login',
            name: 'login',
            builder: (context, state) => LoginPage(),
          ),

          // GoRoute(
          //   path: '/sigin',
          //   name: 'sigin',
          //   builder: (context, state) => SiginPage(),
          // ),
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => MainPage(),
            routes: [
              GoRoute(
                path: '/globalmetrics',
                name: 'global_metrics',
                builder: (context, state) {
                  final bookList = state.extra as List<LibroData>;
                  print(bookList[0]);
                  return GlobalMetricsPage(books: bookList);
                },
              ),

              GoRoute(
                path: '/managebook',
                name: 'create_book',
                builder: (context, state) {
                  final book = state.extra as LibroData?;

                  return ManageBookPage(book: book);
                },
              ),

              GoRoute(
                path: '/book',
                name: 'book',
                builder: (context, state) {
                  final book = state.extra as LibroData;
                  return LibroEstadisticasPage(libroData: book);
                },

                routes: [
                  GoRoute(
                    path: '/managebook',
                    name: 'edit_book',
                    builder: (context, state) {
                      final book = state.extra as LibroData?;
                      return ManageBookPage(book: book);
                    },
                  ),
                  GoRoute(
                    path: '/cronometro',
                    name: 'cronometro',
                    builder: (context, state) {
                      final book = state.extra as LibroData;
                      return CronometroScreen(libro: book);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
