import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// A custom chip widget for selection items like chocolate types
class CustomChip extends StatelessWidget {
  const CustomChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.selectedColor = AppColors.primary,
    this.unselectedColor = Colors.transparent,
    this.borderColor = AppColors.primary,
  }) : super(key: key);

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : unselectedColor,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          label,
          style: AppTextStyles.chipText.copyWith(
            color: isSelected ? AppColors.textWhite : AppColors.textLight,
          ),
        ),
      ),
    );
  }
}
