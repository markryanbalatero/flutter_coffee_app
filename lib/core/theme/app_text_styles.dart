import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Application text styles
class AppTextStyles {
  // Prevent instantiation
  AppTextStyles._();

  // Font families
  static const String sfProText = 'SF Pro Text';
  static const String inter = 'Inter';

  // Header styles
  static const TextStyle titleLarge = TextStyle(
    fontFamily: sfProText,
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.textWhite,
    height: 1.0,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: sfProText,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.overlayText,
    height: 1.0,
  );

  // Rating styles
  static const TextStyle rating = TextStyle(
    fontFamily: sfProText,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textWhite,
    height: 1.0,
  );

  static const TextStyle ratingCount = TextStyle(
    fontFamily: sfProText,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.overlayText,
    height: 1.0,
  );

  // Section styles
  static const TextStyle sectionTitle = TextStyle(
    fontFamily: inter,
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const TextStyle description = TextStyle(
    fontFamily: inter,
    fontSize: 14,
    color: AppColors.textDark,
    height: 1.6,
    letterSpacing: 0.2,
  );

  // Price styles
  static const TextStyle priceLabel = TextStyle(
    fontFamily: inter,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textLight,
    height: 22 / 14,
  );

  static const TextStyle priceCurrency = TextStyle(
    fontFamily: inter,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
    height: 22 / 24,
  );

  static const TextStyle priceAmount = TextStyle(
    fontFamily: inter,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
    height: 22 / 24,
  );

  // Button styles
  static const TextStyle buttonText = TextStyle(
    fontFamily: sfProText,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textWhite,
    height: 22 / 16,
  );

  // Chip styles
  static const TextStyle chipText = TextStyle(
    fontFamily: sfProText,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 22 / 12,
  );

  // Size button styles
  static const TextStyle sizeButtonText = TextStyle(
    fontFamily: inter,
    fontSize: 16,
    height: 22 / 16,
  );

  // Quantity styles
  static const TextStyle quantityText = TextStyle(
    fontFamily: inter,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // Icon label styles
  static const TextStyle iconLabel = TextStyle(
    fontFamily: sfProText,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.iconLabel,
    height: 1.0,
  );

  static const TextStyle mediumRoasted = TextStyle(
    fontFamily: sfProText,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textWhite,
    height: 1.0,
  );

  // Read more style
  static const TextStyle readMore = TextStyle(
    fontFamily: inter,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );
}
