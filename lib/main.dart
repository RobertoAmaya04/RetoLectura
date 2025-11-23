import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:retolectura/src/models/fakeData.dart';
import 'package:retolectura/src/models/libro_data_model.dart';
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
        initialLocation: '/libstats',
        redirect: (context, state) {
          final user = FirebaseAuth.instance.currentUser;
          if (user == null) {
            return '/login';
          }

          return null;
        },
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
          ),

          GoRoute(
            path: '/globalmetrics',
            name: 'global_metrics',
            builder: (context, state) => GlobalMetricsPage(),
          ),

          GoRoute(
            path: '/managebook',
            name: 'manage_book',
            builder: (context, state) {
              //final book = state.extra as LibroData?;
              final book = librosTest[0];
              return ManageBookPage(book: book);
            },
          ),

          GoRoute(
            path: '/libstats',
            name: 'libstats',
            builder: (context, state) => LibroEstadisticasPage(),
          ),
        ],
      ),
    );
  }
}
