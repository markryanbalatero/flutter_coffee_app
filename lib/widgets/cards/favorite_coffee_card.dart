import 'package:flutter/material.dart';
import '../../core/models/coffee_item.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../theme/app_theme.dart';

class FavoriteCoffeeCard extends StatelessWidget {
  final CoffeeItem coffee;
  final VoidCallback onRemoveFromFavorites;
  final VoidCallback onTap;

  const FavoriteCoffeeCard({
    super.key,
    required this.coffee,
    required this.onRemoveFromFavorites,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Coffee Image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(coffee.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Coffee Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(coffee.name, style: AppTheme.favoriteCoffeeNameStyle),
                    const SizedBox(height: 4),
                    Text(
                      coffee.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.favoriteCoffeeDescriptionStyle,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: AppColors.starIcon),
                        const SizedBox(width: 4),
                        Text(
                          coffee.rating.toString(),
                          style: AppTheme.favoriteCoffeeRatingStyle,
                        ),
                        const Spacer(),
                        Text(
                          '\$${coffee.price.toStringAsFixed(2)}',
                          style: AppTheme.favoriteCoffeePriceStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Remove from favorites button
              GestureDetector(
                onTap: onRemoveFromFavorites,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.favoriteButtonBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: AppColors.favoriteIcon,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
