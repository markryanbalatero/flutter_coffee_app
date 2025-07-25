import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../theme/app_theme.dart';

class QuantityControl extends StatelessWidget {
  final int quantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final bool isDarkMode;

  const QuantityControl({
    super.key,
    required this.quantity,
    this.onIncrement,
    this.onDecrement,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: isDarkMode 
          ? AppColors.darkSurface 
          : AppColors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isDarkMode 
            ? AppColors.darkDivider 
            : AppColors.coffeeTextSecondary,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.remove,
              color: isDarkMode 
                ? AppColors.darkOnSurface 
                : AppColors.coffeeTextSecondary,
            ),
            onPressed: onDecrement,
          ),
          Text(
            '$quantity',
            style: AppTheme.chipTextStyle.copyWith(
              color: isDarkMode 
                ? AppColors.darkTextOnBackground 
                : AppColors.coffeeTextSecondary,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: isDarkMode 
                ? AppColors.darkPrimary 
                : AppColors.coffeeAccent,
            ),
            onPressed: onIncrement,
          ),
        ],
      ),
    );
  }
}
