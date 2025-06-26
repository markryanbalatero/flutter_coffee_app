import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_text_styles.dart';
import '../buttons/size_button.dart';
import '../controls/quantity_control.dart';

/// Widget for size and quantity selection
class SizeAndQuantitySection extends StatelessWidget {
  const SizeAndQuantitySection({
    Key? key,
    required this.selectedSize,
    required this.quantity,
    required this.onSizeSelected,
    required this.onQuantityChanged,
    this.sizeOptions = AppConstants.sizeOptions,
  }) : super(key: key);

  final String selectedSize;
  final int quantity;
  final ValueChanged<String> onSizeSelected;
  final ValueChanged<int> onQuantityChanged;
  final List<String> sizeOptions;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double gap = constraints.maxWidth < AppConstants.narrowScreenBreakpoint
            ? AppConstants.narrowScreenGap
            : AppConstants.standardGapSizeQuantity;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSizeSection(),
            SizedBox(width: gap),
            _buildQuantitySection(),
          ],
        );
      },
    );
  }

  /// Builds the size selection section
  Widget _buildSizeSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Size', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppConstants.mediumSpacing),
          Row(
            children: sizeOptions
                .map((size) => [
                      SizeButton(
                        size: size,
                        isSelected: selectedSize == size,
                        onTap: () => onSizeSelected(size),
                      ),
                      if (size != sizeOptions.last) const SizedBox(width: 20),
                    ])
                .expand((widget) => widget)
                .toList(),
          ),
        ],
      ),
    );
  }

  /// Builds the quantity selection section
  Widget _buildQuantitySection() {
    return Column(
      children: [
        const Text('Quantity', style: AppTextStyles.sectionTitle),
        const SizedBox(height: AppConstants.mediumSpacing),
        QuantityControl(
          quantity: quantity,
          onIncrease: () => onQuantityChanged(quantity + 1),
          onDecrease: () => onQuantityChanged(quantity - 1),
        ),
      ],
    );
  }
}
