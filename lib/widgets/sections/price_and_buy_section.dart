import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../buttons/primary_button.dart';

/// A widget that displays the price and buy now button section.
class PriceAndBuySection extends StatefulWidget {
  final double price;
  final VoidCallback? onBuyNow;

  const PriceAndBuySection({
    super.key,
    required this.price,
    this.onBuyNow,
  });

  @override
  State<PriceAndBuySection> createState() => _PriceAndBuySectionState();
}

class _PriceAndBuySectionState extends State<PriceAndBuySection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void didUpdateWidget(PriceAndBuySection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.price != oldWidget.price) {
      // Animate when price changes
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
        AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$',
                    style: AppTextStyles.priceCurrency,
                  ),
                  Text(
                    widget.price.toStringAsFixed(2),
                    style: AppTextStyles.priceAmount,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  /// Builds the buy now button
  Widget _buildBuyNowButton() {
    return Expanded(
      child: PrimaryButton(
        text: 'Buy Now',
        onPressed: widget.onBuyNow,
        height: AppConstants.buyButtonHeight,
      ),
    );
  }
}
