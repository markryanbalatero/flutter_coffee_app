import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_text_styles.dart';
import '../chips/custom_chip.dart';

/// Widget for chocolate selection
class ChocolateSelectionSection extends StatelessWidget {
  const ChocolateSelectionSection({
    Key? key,
    required this.selectedChocolate,
    required this.onChocolateSelected,
    this.title = 'Choice of Chocolate',
    this.options = AppConstants.chocolateOptions,
  }) : super(key: key);

  final String selectedChocolate;
  final ValueChanged<String> onChocolateSelected;
  final String title;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.sectionTitle),
        const SizedBox(height: AppConstants.mediumSpacing),
        SizedBox(
          height: 40,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: options
                  .map((chocolate) => [
                        CustomChip(
                          label: chocolate,
                          isSelected: selectedChocolate == chocolate,
                          onTap: () => onChocolateSelected(chocolate),
                        ),
                        if (chocolate != options.last)
                          const SizedBox(width: AppConstants.mediumSpacing),
                      ])
                  .expand((widget) => widget)
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
