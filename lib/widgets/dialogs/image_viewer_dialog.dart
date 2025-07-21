import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/models/coffee_item.dart';
import '../../core/theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../utils/image_utils.dart';

class ImageViewerDialog extends StatelessWidget {
  final CoffeeItem coffee;
  final String imagePath;

  const ImageViewerDialog({
    super.key,
    required this.coffee,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.imageViewerBackground,
      body: SafeArea(
        child: Stack(
          children: [
            // Main image viewer
            Center(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 3.0,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppConstants.defaultBorderRadius,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.imageViewerShadow,
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppConstants.defaultBorderRadius,
                      ),
                      child: Image(
                        image: ImageUtils.getImageProvider(imagePath),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Close button
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.closeButtonBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: AppColors.closeButtonIcon,
                    size: 24,
                  ),
                ),
              ),
            ),

            // Coffee details overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.gradientStart, AppColors.gradientEnd],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(coffee.name, style: AppTheme.imageViewerTitleStyle),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: AppColors.starIcon, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          coffee.rating.toString(),
                          style: AppTheme.imageViewerRatingStyle,
                        ),
                        const Spacer(),
                        Text(
                          '\$${coffee.price.toStringAsFixed(2)}',
                          style: AppTheme.imageViewerPriceStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      coffee.description,
                      style: AppTheme.imageViewerDescriptionStyle,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap anywhere to close',
                      style: AppTheme.imageViewerHintStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Static method to show the image viewer dialog
  static void show(BuildContext context, CoffeeItem coffee, String imagePath) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ImageViewerDialog(coffee: coffee, imagePath: imagePath),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
