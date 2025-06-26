import 'package:flutter/material.dart';

/// Application color palette
class AppColors {
  // Prevent instantiation
  AppColors._();

  // Primary colors
  static const Color primary = Color(0xFF967259);
  static const Color background = Colors.white;
  
  // Text colors
  static const Color textDark = Color(0xFF444444);
  static const Color textLight = Color(0xFF777777);
  static const Color textSecondary = Color(0xFF2F3548);
  static const Color textWhite = Colors.white;
  
  // Overlay colors
  static const Color overlay = Color(0x4D000000);
  static const Color overlayText = Color(0xCCFFFFFF);
  static const Color iconLabel = Color(0xFFDDDDDD);
  
  // Button colors
  static const Color buttonInactive = Color(0xFFE8E8E8);
  
  // Semantic colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF8B5A42)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
