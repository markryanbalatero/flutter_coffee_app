import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_text_styles.dart';

/// Content for the product info overlay
class ProductOverlayContent extends StatelessWidget {
  const ProductOverlayContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProductTitleSection(),
        const SizedBox(width: AppConstants.overlayGap),
        _buildProductIconsSection(),
      ],
    );
  }

  /// Builds the left section with title, subtitle, and rating
  Widget _buildProductTitleSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppConstants.productName, style: AppTextStyles.titleLarge),
              const SizedBox(height: 2),
              Text(AppConstants.productSubtitle, style: AppTextStyles.subtitle),
            ],
          ),
          _buildRatingSection(),
        ],
      ),
    );
  }

  /// Builds the rating section with star and reviews
  Widget _buildRatingSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(AppConstants.starIcon, width: 19, height: 19),
        const SizedBox(width: 6),
        Text(AppConstants.productRating, style: AppTextStyles.rating),
        const SizedBox(width: 6),
        Text(AppConstants.productReviews, style: AppTextStyles.ratingCount),
      ],
    );
  }

  /// Builds the right section with coffee and chocolate icons
  Widget _buildProductIconsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIconColumn(AppConstants.coffeeIcon, 'Coffee'),
            const SizedBox(width: 30),
            _buildIconColumn(AppConstants.dropIcon, 'Chocolate'),
          ],
        ),
        Text(AppConstants.productRoastLevel, style: AppTextStyles.mediumRoasted),
      ],
    );
  }

  /// Builds an icon column with label
  Widget _buildIconColumn(String iconPath, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(iconPath, width: 24, height: 24),
        const SizedBox(height: 3),
        Text(label, style: AppTextStyles.iconLabel),
      ],
    );
  }
}
