import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/app_colors.dart';
import '../utils/image_utils.dart';

class CoffeeCard extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final double rating;
  final String imageAsset;
  final VoidCallback? onTap;
  final VoidCallback? onAddTap;

  const CoffeeCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.imageAsset,
    this.onTap,
    this.onAddTap,
  });

  double _getCardNameFontSize(String name) {
    if (name.length <= 8) {
      return 18.0; 
    } else if (name.length <= 12) {
      return 16.0;
    } else if (name.length <= 16) {
      return 14.0;
    } else if (name.length <= 20) {
      return 12.0;
    } else {
      return 10.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.coffeeCardBackground,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: AppColors.coffeeCardShadow,
              blurRadius: 24,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 11, 10, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                    image: ImageUtils.getImageProvider(imageAsset),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 4,
                        ),
                        decoration: ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.00, -1.00),
                            end: Alignment(0, 1),
                            colors: [
                              AppColors.coffeeRatingBackground,
                              AppColors.coffeeRatingBackground,
                            ],
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: AppColors.coffeeRating,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              rating.toString(),
                              style: AppTheme.coffeeCardRatingStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(19, 13, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTheme.coffeeCardNameStyle.copyWith(
                        fontSize: _getCardNameFontSize(name),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: AppTheme.coffeeCardDescriptionStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(19, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '\$ ',
                            style: AppTheme.coffeeCardPriceCurrencyStyle,
                          ),
                          TextSpan(
                            text: price.toStringAsFixed(2),
                            style: AppTheme.coffeeCardPriceAmountStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onAddTap,
                    child: Container(
                      width: 52,
                      height: 53,
                      decoration: const BoxDecoration(
                        color: AppColors.coffeeAccent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.buttonTextColor,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
