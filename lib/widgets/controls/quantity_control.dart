import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// A widget for controlling quantity with increase/decrease buttons
class QuantityControl extends StatelessWidget {
  const QuantityControl({
    super.key,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    this.minQuantity = 1,
  });

  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final int minQuantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _QuantityButton(
          icon: Icons.remove,
          onTap: quantity > minQuantity ? onDecrease : null,
        ),
        const SizedBox(width: AppConstants.quantityButtonGap),
        Text('$quantity', style: AppTextStyles.quantityText),
        const SizedBox(width: AppConstants.quantityButtonGap),
        _QuantityButton(
          icon: Icons.add,
          onTap: onIncrease,
        ),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppConstants.fastAnimationDuration,
        width: AppConstants.circularButtonSize,
        height: AppConstants.circularButtonSize,
        decoration: BoxDecoration(
          color: onTap != null ? AppColors.primary : AppColors.buttonInactive,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: onTap != null ? AppColors.textWhite : AppColors.textLight,
          size: 18,
        ),
      ),
    );
  }
}
