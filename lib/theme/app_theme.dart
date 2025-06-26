import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AppTheme {
  // Color constants - using AppColors for consistency
  static const Color backgroundColor = AppColors.backgroundColor;
  static const Color buttonColor = AppColors.buttonColor;
  static const Color textColor = AppColors.textColor;
  static const Color inputTextColor = AppColors.inputTextColor;

  // TextStyles
  static const TextStyle inputTextStyle = TextStyle(
    fontSize: 20,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    color: AppColors.inputTextColor,
    height: 1.15,
  );

  static const TextStyle hintTextStyle = TextStyle(
    color: AppColors.inputTextColor,
    fontSize: 20,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
  );

  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: AppColors.textColor,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    color: AppColors.buttonTextColor,
  );

  // Dashboard specific text styles
  static const TextStyle greetingStyle = TextStyle(
    color: AppColors.greetingTextColor,
    fontSize: 22,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    height: 32 / 22,
    letterSpacing: 0,
  );

  // Category tab text styles
  static TextStyle categoryTabSelectedStyle = const TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.categoryTabSelectedColor,
  );

  static TextStyle categoryTabUnselectedStyle = const TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.categoryTabUnselectedColor,
  );

  // Special offer card text styles
  static const TextStyle specialOfferTitleStyle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.specialOfferTitleColor,
  );

  static const TextStyle specialOfferDescriptionStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.specialOfferDescriptionColor,
    height: 1.57,
  );

  static const TextStyle specialOfferPriceStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.specialOfferPriceColor,
  );

  static const TextStyle specialOfferOriginalPriceStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.specialOfferOriginalPriceColor,
    decoration: TextDecoration.lineThrough,
  );

  // Theme data
  static ThemeData get theme {
    return ThemeData(
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: AppColors.backgroundColor,
      primaryColor: AppColors.buttonColor,

      // Text theme from second file
      textTheme: const TextTheme(
        bodyMedium: inputTextStyle,
        titleMedium: titleStyle,
        labelLarge: buttonTextStyle,
      ),

      // Input decoration theme combining elements from both files
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFieldBackground,
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
        contentPadding: const EdgeInsets.only(
          left: 27,
          right: 20,
          top: 13,
          bottom: 13,
        ),
        hintStyle: hintTextStyle,
      ),
    );
  }
}
