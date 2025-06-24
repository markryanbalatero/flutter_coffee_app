import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AppTheme {

  static const Color backgroundColor = AppColors.backgroundColor;
  static const Color textColor = AppColors.textColor;
  static const Color buttonColor = AppColors.buttonColor;

 
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

  static ThemeData get theme {
    return ThemeData(
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: AppColors.backgroundColor,
      primaryColor: AppColors.buttonColor,

      textTheme: const TextTheme(
        bodyMedium: inputTextStyle, 
        titleMedium: titleStyle, 
        labelLarge: buttonTextStyle, 
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputFieldBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
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
