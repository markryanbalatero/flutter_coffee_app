import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../theme/app_theme.dart';

/// Widget for chocolate selection
class ChocolateSelectionSection extends StatelessWidget {
  final String selectedChocolate;
  final Function(String) onChocolateSelected;
  final bool isDarkMode;

  const ChocolateSelectionSection({
    super.key,
    required this.selectedChocolate,
    required this.onChocolateSelected,
    this.isDarkMode = false,
  });

  final List<String> chocolateOptions = const [
    'White Chocolate',
    'Milk Chocolate',
    'Dark Chocolate',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chocolate',
          style: AppTheme.sectionTitleStyle.copyWith(
            color: isDarkMode 
              ? AppColors.darkTextOnBackground 
              : null,
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: chocolateOptions.map((chocolate) {
              final isSelected = selectedChocolate == chocolate;
              return GestureDetector(
                onTap: () => onChocolateSelected(chocolate),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15, 
                    vertical: 10
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (isDarkMode 
                            ? AppColors.darkPrimary 
                            : AppColors.coffeeAccent)
                        : (isDarkMode 
                            ? AppColors.darkSurface 
                            : AppColors.transparent),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: isSelected
                          ? (isDarkMode 
                              ? AppColors.darkPrimary 
                              : AppColors.coffeeAccent)
                          : (isDarkMode 
                              ? AppColors.darkDivider 
                              : AppColors.coffeeTextSecondary),
                    ),
                  ),
                  child: Text(
                    chocolate,
                    style: AppTheme.chipTextStyle.copyWith(
                      color: isSelected
                          ? (isDarkMode 
                              ? AppColors.darkOnPrimary 
                              : Colors.white)
                          : (isDarkMode 
                              ? AppColors.darkOnSurface 
                              : AppColors.coffeeTextSecondary),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
