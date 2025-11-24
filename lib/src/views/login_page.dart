import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:retolectura/src/services/google-signIn.dart';
import 'package:retolectura/src/widgets/Utils.dart';
import 'package:retolectura/src/widgets/snackbar_personalizado.dart';
import 'package:retolectura/src/widgets/style_default.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Bienvenido',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  labelText: 'Correo electrónico',
                  icon: Icons.mail,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Contraseña',
                  icon: Icons.lock,
                  keyboardType: TextInputType.text,
                  controller: passwordController,
                  obscure: true,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Login button pressed (no logic)
                      if (emailController.text.trim().isEmpty) {
                        CustomSnackBar.show(
                          context,
                          message: 'Por favor, ingresa un correo.',
                        );
                        return;
                      }
                      if (passwordController.text.trim().isEmpty) {
                        CustomSnackBar.show(
                          context,
                          message: 'Por favor, ingresa una contraseña.',
                        );
                        return;
                      }
                      if (!Utils.isValidEmail(emailController.text.trim())) {
                        CustomSnackBar.show(
                          context,
                          message: 'Por favor, ingresa un correo válido.',
                        );
                        return;
                      }

                      if (!Utils.isPasswordSecure(
                        passwordController.text.trim(),
                      )) {
                        CustomSnackBar.show(
                          context,
                          message:
                              'La contraseña debe tener al menos 8 caracteres.',
                        );
                        return;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF6A1B9A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final user = await GoogleSigin.handleGoogleSignIn();

                      if (user != null && context.mounted) {
                        context.pushReplacement('/home');
                      } else {
                        return;
                      }
                    },
                    icon: Image.network(
                      'https://cdn.icon-icons.com/icons2/836/PNG/512/Google_icon-icons.com_66793.png',
                      height: 24.0,
                      width: 24.0,
                    ),
                    label: const Text(
                      'Continuar con Google',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white70, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
