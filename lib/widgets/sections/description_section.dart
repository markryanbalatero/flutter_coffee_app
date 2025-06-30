import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';
import '../text/expandable_text.dart';

/// Widget for displaying product description
class DescriptionSection extends StatelessWidget {
  const DescriptionSection({
    Key? key,
    this.title = 'Description',
    this.initialDescription =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
        'Vel tincidunt et ullamcorper eu, vivamus semper commodo............',
    this.fullDescription =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
        'Vel tincidunt et ullamcorper eu, vivamus semper commodo............'
        'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. '
        'Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. '
        'Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. '
        'Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra.',
    this.maxLines = 3,
  }) : super(key: key);

  final String title;
  final String initialDescription;
  final String fullDescription;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.sectionTitle),
        const SizedBox(height: 5),
        ExpandableText(
          text: fullDescription,
          initialText: initialDescription,
          maxLines: maxLines,
          textStyle: AppTextStyles.description,
          linkStyle: AppTextStyles.readMore,
          animation: true,
        ),
      ],
    );
  }
}
