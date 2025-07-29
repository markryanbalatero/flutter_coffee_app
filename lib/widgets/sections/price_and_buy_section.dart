import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../theme/app_theme.dart';
import '../buttons/primary_button.dart';

class PriceAndBuySection extends StatelessWidget {
  final double price;
  final VoidCallback onBuyNow;
  final bool isDarkMode;

  const PriceAndBuySection({
    super.key,
    required this.price,
    required this.onBuyNow,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price',
              style: AppTheme.sectionTitleStyle.copyWith(
                color: isDarkMode 
                  ? AppColors.darkTextOnBackground 
                  : null,
              ),
            ),
            const SizedBox(height: 5),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\$ ',
                    style: AppTheme.coffeeCardPriceCurrencyStyle.copyWith(
                      color: isDarkMode 
                        ? AppColors.darkPrimary 
                        : null,
                    ),
                  ),
                  TextSpan(
                    text: price.toStringAsFixed(2),
                    style: AppTheme.coffeeCardPriceAmountStyle.copyWith(
                      color: isDarkMode 
                        ? AppColors.darkTextOnBackground 
                        : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        PrimaryButton(
          text: 'Buy Now',
          onPressed: onBuyNow,
          height: 40, // Reduced height
          width: 200, // Fixed width
          backgroundColor: isDarkMode 
            ? AppColors.darkPrimary 
            : AppColors.buttonColor,
          textColor: isDarkMode 
            ? AppColors.darkOnPrimary 
            : Colors.white,
        ),
      ],
    );
  }
}
