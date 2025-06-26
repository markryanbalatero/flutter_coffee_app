import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../buttons/primary_button.dart';

/// A widget that displays the price and buy now button section.
class PriceAndBuySection extends StatelessWidget {
  final double price;
  final VoidCallback? onBuyNow;

  const PriceAndBuySection({
    super.key,
    required this.price,
    this.onBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double gap = constraints.maxWidth < 350 
            ? AppConstants.narrowScreenGap 
            : AppConstants.standardGapPriceBuy;
        
        return Row(
          children: [
            _buildPriceSection(),
            SizedBox(width: gap),
            _buildBuyNowButton(),
          ],
        );
      },
    );
  }

  /// Builds the price display section
  Widget _buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Price', style: AppTextStyles.priceLabel),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\$',
              style: AppTextStyles.priceCurrency,
            ),
            Text(
              price.toStringAsFixed(2),
              style: AppTextStyles.priceAmount,
            ),
          ],
        ),
      ],
    );
  }

  /// Builds the buy now button
  Widget _buildBuyNowButton() {
    return Expanded(
      child: PrimaryButton(
        text: 'Buy Now',
        onPressed: onBuyNow,
        height: AppConstants.buyButtonHeight,
      ),
    );
  }
}
