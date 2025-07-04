import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/core/models/coffee_item.dart';
import '../../core/theme/app_text_styles.dart';
import '../text/expandable_text.dart';

/// Widget for displaying product_details description
class DescriptionSection extends StatelessWidget {
  final CoffeeItem coffeeItem;

  final int maxLines;

  const DescriptionSection(this.coffeeItem, {super.key, this.maxLines = 3});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(coffeeItem.name, style: AppTextStyles.sectionTitle),
        const SizedBox(height: 5),
        ExpandableText(
          text: coffeeItem.description,
          initialText: coffeeItem.description,
          maxLines: maxLines,
          textStyle: AppTextStyles.description,
          linkStyle: AppTextStyles.readMore,
          animation: true,
        ),
      ],
    );
  }
}
