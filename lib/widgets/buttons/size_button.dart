import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// A circular button for size selection
class SizeButton extends StatelessWidget {
  const SizeButton({
    Key? key,
    required this.size,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final String size;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppConstants.defaultAnimationDuration,
        width: AppConstants.circularButtonSize,
        height: AppConstants.circularButtonSize,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.buttonInactive,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            size,
            style: AppTextStyles.sizeButtonText.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? AppColors.textWhite : AppColors.textLight,
            ),
          ),
        ),
      ),
    );
  }
}
