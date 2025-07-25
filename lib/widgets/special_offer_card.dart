import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../theme/app_theme.dart';

class SpecialOfferCard extends StatelessWidget {
  final String title;
  final String description;
  final double currentPrice;
  final double originalPrice;
  final String imageAsset;
  final VoidCallback? onTap;

  const SpecialOfferCard({
    super.key,
    required this.title,
    required this.description,
    required this.currentPrice,
    required this.originalPrice,
    required this.imageAsset,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTheme.specialOfferTitleStyle),
        const SizedBox(height: 15),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 145,
            decoration: BoxDecoration(
              color: const Color(0xFF967259),
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.specialOfferCardShadow,
                  blurRadius: 24,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 130,
                  height: 130,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/coffee_espresso.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          description,
                          style: AppTheme.specialOfferDescriptionStyle,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              '\$${currentPrice.toStringAsFixed(2)}',
                              style: AppTheme.specialOfferPriceStyle,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '\$${originalPrice.toStringAsFixed(1)}',
                              style: AppTheme.specialOfferOriginalPriceStyle,
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
        ),
      ],
    );
  }
}
