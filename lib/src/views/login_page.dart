import 'package:flutter/material.dart';
import 'package:retolectura/src/services/google-signIn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: GoogleSigin.handleGoogleSignIn,
          child: Text('inicio de sesion con google'),
        ),
      ),
    );
  }
}
