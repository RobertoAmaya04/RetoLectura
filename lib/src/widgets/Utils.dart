import 'package:flutter/material.dart';

class Utils {
  
  // COlORES
  static final primaryColor = Colors.red;
  static final secondaryColor = Colors.blue;
  static final textColor = Colors.white;
  static final backgroundColor = Colors.black;

  static bool isValidEmail(String email) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(email);
  }

  static bool isPasswordSecure(String password) {
    return password.length >= 8;
  }

}