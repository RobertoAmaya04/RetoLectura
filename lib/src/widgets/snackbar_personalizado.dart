import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    IconData? icon,
    int durationSeconds = 3,
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 8,
      duration: Duration(seconds: durationSeconds),
      backgroundColor: Colors.transparent,
      content: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6A1B9A),
              Color(0xFF9C27B0),
              Color(0xFFE040FB),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            if (icon != null)
              Icon(icon, color: Colors.white, size: 26),
            if (icon != null)
              SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
