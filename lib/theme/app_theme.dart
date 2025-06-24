import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      fontFamily: 'Roboto',
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          color: const Color(0xFF7C7C7C),
        ),
      ),
    );
  }
  static const Color backgroundColor = Color(0xFFECE0D1);
  static const Color buttonColor = Color(0xFF967259);
  static const Color textColor = Colors.black;
  static const Color inputTextColor = Color(0xFF7C7C7C);
}
