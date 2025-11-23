import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {// Definición del widget CustomTextField
  final String hintText;// Texto de sugerencia
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscure;
  final ValueChanged<String>? onChanged;// Callback opcional al cambiar el texto

  const CustomTextField({
    super.key,// Clave opcional para el widget
    required this.hintText,// Texto de sugerencia obligatorio
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscure = false,
    this.onChanged,// Callback opcional al cambiar el texto
  });

  @override
  Widget build(BuildContext context) {// Construcción del widget TextField personalizado
    return TextField(// Widget TextField
      controller: controller,// Controlador opcional
      keyboardType: keyboardType,// Tipo de teclado
      obscureText: obscure,// Ocultar texto si es necesario
      onChanged: onChanged,// Callback opcional al cambiar el texto
      decoration: InputDecoration(// Estilos personalizados
        hintText: hintText,// Texto de sugerencia
        filled: true,// Campo relleno
        fillColor: const Color.fromARGB(255, 255, 255, 255), // Fondo blanco
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), // Espaciado interno
        enabledBorder: OutlineInputBorder(// Borde cuando no está enfocado
          borderRadius: BorderRadius.circular(12),// Bordes redondeados
          borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),// Sin borde cuando no está enfocado
        ),
        focusedBorder: OutlineInputBorder(// Borde cuando está enfocado
          borderRadius: BorderRadius.circular(12),// Bordes redondeados
          borderSide: const BorderSide(color: Colors.green, width: 2), // Borde verde cuando está enfocado
        ),
      ),
    );
  }
}