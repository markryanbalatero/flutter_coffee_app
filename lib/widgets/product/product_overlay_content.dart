import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/models/coffee_item.dart';

class ProductOverlayContent extends StatelessWidget {
  final CoffeeItem coffee;

  const ProductOverlayContent({super.key, required this.coffee});

  double _getResponsiveFontSize(String text) {
    if (text.length <= 12) {
      return 24.0;
    } else if (text.length <= 18) {
      return 20.0;
    } else if (text.length <= 25) {
      return 18.0;
    } else {
      return 16.0;
    }
  }

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
              Text(
                coffee.name,
                style: AppTextStyles.titleLarge.copyWith(
                  fontSize: _getResponsiveFontSize(coffee.name),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(coffee.description, style: AppTextStyles.subtitle),
            ],
          ),
          _buildRatingAndPriceSection(),
        ],
      ),
    );
  }

  Widget _buildRatingAndPriceSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AppConstants.starIcon, width: 19, height: 19),
            const SizedBox(width: 6),
            Text(coffee.rating.toString(), style: AppTextStyles.rating),
            const SizedBox(width: 6),
            Text(
              '(${(coffee.rating * 1000).toInt()})',
              style: AppTextStyles.ratingCount,
            ),
          ],
        ),
        Text(
          '\$${coffee.price.toStringAsFixed(2)}',
          style: AppTextStyles.rating.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildProductIconsSection() {
    bool hasChocolate = _hasChocolate();
    String roastLevel = _getRoastLevel();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIconColumn(AppConstants.coffeeIcon, 'Coffee'),
            const SizedBox(width: 30),
            _buildIconColumn(
              AppConstants.dropIcon,
              hasChocolate ? 'Chocolate' : 'Milk',
            ),
          ],
        ),
        Text(roastLevel, style: AppTextStyles.mediumRoasted),
      ],
    );
  }

  bool _hasChocolate() {
    final lowerName = coffee.name.toLowerCase();
    final lowerDesc = coffee.description.toLowerCase();

    return lowerName.contains('chocolate') ||
        lowerDesc.contains('chocolate') ||
        lowerName.contains('mocha') ||
        lowerDesc.contains('mocha');
  }

  String _getRoastLevel() {
    final lowerName = coffee.name.toLowerCase();

    if (lowerName.contains('espresso')) {
      return 'Dark Roasted';
    } else if (lowerName.contains('latte') ||
        lowerName.contains('cappuccino')) {
      return 'Medium Roasted';
    } else if (lowerName.contains('americano') ||
        lowerName.contains('french')) {
      return 'Medium Roasted';
    } else {
      return 'Medium Roasted';
    }
  }

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
