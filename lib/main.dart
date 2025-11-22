import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:retolectura/src/models/libro_data_model.dart';
import 'package:retolectura/src/provider/data_provider.dart';
import 'package:retolectura/src/services/google-signIn.dart';
import 'package:retolectura/src/views/libro_estadisticas.dart';
import 'package:retolectura/src/views/login_page.dart';
import 'package:retolectura/src/views/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: MainPage());
  }
}
