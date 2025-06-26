import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../theme/app_theme.dart';

class CategoryTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryTab({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 30),
        child: Column(
          children: [
            Text(
              title,
              style: isSelected
                  ? AppTheme.categoryTabSelectedStyle
                  : AppTheme.categoryTabUnselectedStyle,
            ),
            const SizedBox(height: 5),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.categoryTabSelectedColor
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
