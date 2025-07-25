import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../theme/app_theme.dart';
import '../controls/quantity_control.dart';

class SizeAndQuantitySection extends StatelessWidget {
  final String selectedSize;
  final int quantity;
  final Function(String) onSizeSelected;
  final Function(int) onQuantityChanged;
  final bool isDarkMode;

  const SizeAndQuantitySection({
    super.key,
    required this.selectedSize,
    required this.quantity,
    required this.onSizeSelected,
    required this.onQuantityChanged,
    this.isDarkMode = false,
  });

  final List<String> sizeOptions = const ['S', 'M', 'L'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Size',
              style: AppTheme.sectionTitleStyle.copyWith(
                color: isDarkMode 
                  ? AppColors.darkTextOnBackground 
                  : null,
              ),
            ),
            Text(
              'Quantity',
              style: AppTheme.sectionTitleStyle.copyWith(
                color: isDarkMode 
                  ? AppColors.darkTextOnBackground 
                  : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: sizeOptions.map((size) {
                    final isSelected = selectedSize == size;
                    return GestureDetector(
                      onTap: () => onSizeSelected(size),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 50,
                        height: 50,
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
                        child: Center(
                          child: Text(
                            size,
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
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            
            Expanded(
              flex: 1,
              child: QuantityControl(
                quantity: quantity,
                onIncrement: () => onQuantityChanged(quantity + 1),
                onDecrement: () => quantity > 1 
                  ? onQuantityChanged(quantity - 1) 
                  : null,
                isDarkMode: isDarkMode,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
