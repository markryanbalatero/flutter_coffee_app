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

  // Coffee card text styles
  static const TextStyle coffeeCardNameStyle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.coffeeTextDark,
  );

  static const TextStyle coffeeCardDescriptionStyle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.coffeeDescriptionText,
  );

  static const TextStyle coffeeCardRatingStyle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.coffeeRatingText,
  );

  static const TextStyle coffeeCardPriceCurrencyStyle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.coffeePrice,
  );

  static const TextStyle coffeeCardPriceAmountStyle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.coffeeTextDark,
  );

  // Search bar text styles
  static const TextStyle searchBarTextStyle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.searchTextColor,
  );

  static const TextStyle searchBarHintStyle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.searchHintColor,
    height: 18 / 12,
  );

  // App text styles - common text styles used throughout the app
  static const TextStyle appTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: AppColors.primaryText,
    height: 1.57,
  );

  // Custom button text style
  static const TextStyle customButtonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    color: AppColors.buttonTextColor,
  );

  // Splash screen text styles
  static const TextStyle splashTitleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    fontFamily: 'SF Pro Text',
    color: AppColors.primaryText,
  );

  static const TextStyle splashDescriptionStyle = TextStyle(
    fontSize: 14,
    color: AppColors.secondaryText,
  );

  static const TextStyle splashButtonTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );

  // Login screen text styles
  static const TextStyle loginTitleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: AppColors.textColor,
  );

  static const TextStyle loginErrorStyle = TextStyle(
    color: Colors.red,
    fontSize: 14,
  );

  // Dashboard screen text styles
  static const TextStyle dashboardSearchHeaderStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.coffeeTextDark,
  );

  static const TextStyle dashboardSearchCountStyle = TextStyle(
    fontSize: 14,
    color: AppColors.coffeeTextSecondary,
  );

  static const TextStyle dashboardNoResultsTitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.coffeeTextDark,
  );

  static const TextStyle dashboardNoResultsDescriptionStyle = TextStyle(
    fontSize: 14,
    color: AppColors.coffeeTextSecondary,
  );

  // Coffee tab bar text styles
  static const TextStyle coffeeTabBarSelectedStyle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle coffeeTabBarUnselectedStyle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle coffeeTabBarCustomTextStyle = TextStyle(
    fontSize: 14,
    fontFamily: 'SF Pro Text',
    fontWeight: FontWeight.w500,
  );

  static const TextStyle coffeeTabBarPromotionStyle = TextStyle(
    color: Colors.white,
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle coffeeTabBarTitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  // Coffee tab bar product_details card styles
  static const TextStyle coffeeTabBarProductTitleStyle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.coffeeTextDark,
  );

  static const TextStyle coffeeTabBarProductSubtitleStyle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.coffeeTextSecondary,
  );

  static const TextStyle coffeeTabBarProductPriceCurrencyStyle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.coffeePrice,
  );

  static const TextStyle coffeeTabBarProductPriceStyle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.coffeeTextDark,
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
          borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.1)),
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

  // Image viewer text styles
  static const TextStyle imageViewerTitleStyle = TextStyle(
    color: Color(0xFFFFFFFF),
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle imageViewerRatingStyle = TextStyle(
    color: Color(0xFFFFFFFF),
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle imageViewerPriceStyle = TextStyle(
    color: Color(0xFFFFFFFF),
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle imageViewerDescriptionStyle = TextStyle(
    color: Color(0xB3FFFFFF),
    fontSize: 14,
    height: 1.4,
  );

  static const TextStyle imageViewerHintStyle = TextStyle(
    color: Color(0x99FFFFFF),
    fontSize: 12,
    fontStyle: FontStyle.italic,
  );

  // Favorite coffee card text styles
  static const TextStyle favoriteCoffeeNameStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.coffeeTextDark,
  );

  static const TextStyle favoriteCoffeeDescriptionStyle = TextStyle(
    fontSize: 14,
    color: AppColors.coffeeTextSecondary,
    height: 1.3,
  );

  static const TextStyle favoriteCoffeeRatingStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.coffeeTextDark,
  );

  static const TextStyle favoriteCoffeePriceStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.coffeePrice,
  );

  // Coffee screen text styles
  static const TextStyle recommendationTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.coffeeTextDark,
  );

  static const TextStyle recommendationTextStyle = TextStyle(
    fontSize: 14,
    color: AppColors.coffeeTextSecondary,
  );

  static const TextStyle errorTextStyle = TextStyle(color: Colors.red);
}
