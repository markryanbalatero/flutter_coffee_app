import 'package:flutter/material.dart';
import 'dart:ui';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/models/coffee_item.dart';
import '../../widgets/buttons/circular_icon_button.dart';
import '../../widgets/buttons/heart_button.dart';
import 'product_overlay_content.dart';

/// Header widget containing product_details image and overlay
class ProductHeader extends StatelessWidget {
  const ProductHeader({
    super.key,
    required this.onBackPressed,
    required this.onFavoritePressed,
    required this.isFavorite,
    required this.coffee,
    this.onImageTap,
  });

  final VoidCallback onBackPressed;
  final VoidCallback onFavoritePressed;
  final bool isFavorite;
  final CoffeeItem coffee;
  final VoidCallback? onImageTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConstants.headerHeight,
      width: double.infinity,
      child: Stack(
        children: [
          _buildProductImage(),
          _buildTopNavigation(),
          _buildProductInfoOverlay(),
        ],
      ),
    );
  }

  /// Builds the product_details background image
  Widget _buildProductImage() {
    return GestureDetector(
      onTap: onImageTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(13, 13, 13, 0),
        height: AppConstants.imageHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          image: DecorationImage(
            image: AssetImage(coffee.image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  /// Builds the top navigation with back and favorite buttons
  Widget _buildTopNavigation() {
    return Positioned(
      left: 24,
      top: 35.857,
      right: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircularIconButton(
            iconPath: AppConstants.backArrowIcon,
            onTap: onBackPressed,
            showVisualFeedbackOnly: false, // Enable back navigation
          ),
          HeartButton(isFavorite: isFavorite, onTap: onFavoritePressed),
        ],
      ),
    );
  }

  /// Builds the product_details info overlay with blur effect
  Widget _buildProductInfoOverlay() {
    return Positioned(
      left: 13,
      right: 13,
      bottom: 0,
      child: Container(
        height: AppConstants.overlayHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          color: AppColors.overlay,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              padding: const EdgeInsets.fromLTRB(27, 25, 26, 25),
              child: SizedBox(
                height: AppConstants.overlayContentHeight,
                child: ProductOverlayContent(coffee: coffee),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
