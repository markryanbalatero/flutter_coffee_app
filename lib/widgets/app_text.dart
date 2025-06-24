import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final String fontFamily;

  const AppText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w400,
    this.color = AppColors.primaryText,
    this.textAlign = TextAlign.start,
    this.fontFamily = 'Roboto',
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        height: 1.57,
      ),
    );
  }
}
