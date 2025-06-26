import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';

/// Widget for displaying product description
class DescriptionSection extends StatelessWidget {
  const DescriptionSection({
    Key? key,
    this.title = 'Description',
    this.description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
        'Vel tincidunt et ullamcorper eu, vivamus semper commodo............',
    this.readMoreText = 'Read More',
    this.onReadMoreTap,
  }) : super(key: key);

  final String title;
  final String description;
  final String readMoreText;
  final VoidCallback? onReadMoreTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.sectionTitle),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            style: AppTextStyles.description,
            children: [
              TextSpan(text: description),
              WidgetSpan(
                child: GestureDetector(
                  onTap: onReadMoreTap,
                  child: Text(readMoreText, style: AppTextStyles.readMore),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
