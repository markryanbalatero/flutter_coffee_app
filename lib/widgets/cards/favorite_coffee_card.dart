import 'package:flutter/material.dart';
import '../../core/models/coffee_item.dart';
import '../../core/theme/app_colors.dart';
import '../../theme/app_theme.dart';
import 'dart:convert';

class FavoriteCoffeeCard extends StatelessWidget {
  Widget _buildCoffeeImage(String image) {
    if (image.startsWith('assets/')) {
      return Container(
        width: 130,
        height: 130,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (image.isNotEmpty) {
      try {
        final bytes = image.contains(',') ? image.split(',').last : image;
        return Container(
          width: 130,
          height: 130,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
              image: MemoryImage(base64Decode(bytes)),
              fit: BoxFit.cover,
            ),
          ),
        );
      } catch (e) {
        return const Icon(Icons.broken_image, size: 40);
      }
    } else {
      return const Icon(Icons.broken_image, size: 40);
    }
  }

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
        width: double.infinity,
        height: 145,
        decoration: BoxDecoration(
          color: const Color(0xFF967259),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            _buildCoffeeImage(coffee.image),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coffee.name,
                      style: AppTheme.favoriteCoffeeNameStyle
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      coffee.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.specialOfferDescriptionStyle
                          .copyWith(color: Colors.white),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: const Color.fromARGB(255, 189, 88, 29)),
                        const SizedBox(width: 4),
                        Text(
                          coffee.rating.toString(),
                          style: AppTheme.favoriteCoffeeRatingStyle
                              .copyWith(color: Colors.white),
                        ),
                        const Spacer(),
                        Text(
                          '\$${coffee.price.toStringAsFixed(2)}',
                          style: AppTheme.specialOfferPriceStyle
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(width: 5),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
