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

  // Button colors
  static const Color buttonBackground = Colors.white;
  static const Color buttonBackgroundPressed = Color(0xFFCCCCCC);
  static const Color iconColor = Color(0xFF000000);

  // Image viewer colors
  static const Color imageViewerBackground = Color(0xE6000000);
  static const Color imageViewerShadow = Color(0x4D000000);
  static const Color closeButtonBackground = Color(0x80000000);
  static const Color closeButtonIcon = Color(0xFFFFFFFF);
  static const Color gradientStart = Color(0x00000000);
  static const Color gradientEnd = Color(0xCC000000);
  static const Color starIcon = Color(0xFFC107);
  static const Color imageViewerText = Color(0xFFFFFFFF);
  static const Color imageViewerTextSecondary = Color(0xB3FFFFFF);
  static const Color imageViewerHint = Color(0x99FFFFFF);

  // Card colors
  static const Color cardBackground = Colors.white;
  static const Color cardShadow = Color(0x0D000000);
  static const Color favoriteButtonBackground = Color(0x1AF44336);
  static const Color favoriteIcon = Color(0xFFE53935);

  // Recommendation colors
  static const Color recommendationBackground = Color(0x1A967259);

  // Error colors
  static const Color errorBackground = Color(0x1AF44336);
  static const Color errorBorder = Color(0x4DF44336);
  static const Color errorIcon = Color(0xFFF44336);
  static const Color errorText = Color(0xFFF44336);

  // Heart button colors
  static const Color heartButtonShadow = Color(0x4DF44336);
  static const Color heartIconActive = Color(0xFFF44336);
  static const Color heartIconInactive = Color(0xFF757575);

  // Add coffee screen colors
  static const Color imageUploadBorder = Color(0x32777777);
  static const Color imageUploadBackground = Color(0xFFE8E8E8);
  static const Color chocolateWhite = Color(0xFFF5F5F5);
  static const Color chocolateDark = Color(0xFF2D1810);
  static const Color quantityButtonBackground = Color(0xFF967259);
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF8B5A42)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
