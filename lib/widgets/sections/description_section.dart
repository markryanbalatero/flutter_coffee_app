import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/core/models/coffee_item.dart';
import '../../utils/app_colors.dart';
import '../../theme/app_theme.dart';
import '../text/expandable_text.dart';

class DescriptionSection extends StatelessWidget {
  final CoffeeItem coffeeItem;
  final bool isDarkMode;
  final int maxLines;

  const DescriptionSection(
    this.coffeeItem, {
    super.key, 
    this.isDarkMode = false,
    this.maxLines = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description', 
          style: AppTheme.sectionTitleStyle.copyWith(
            color: isDarkMode 
              ? AppColors.darkTextOnBackground 
              : null,
          ),
        ),
        const SizedBox(height: 8),
        ExpandableText(
          text: coffeeItem.description,
          maxLines: maxLines,
          textStyle: AppTheme.productDescriptionStyle.copyWith(
            color: isDarkMode 
              ? AppColors.darkOnSurface 
              : null,
          ),
          linkStyle: TextStyle(
            color: isDarkMode 
              ? AppColors.darkPrimary 
              : AppColors.coffeeAccent,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
          ),
          animation: true,
        ),
      ],
    );
  }
}
