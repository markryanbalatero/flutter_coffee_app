import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';

/// A reusable circular button widget with an SVG icon
class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    Key? key,
    required this.iconPath,
    required this.onTap,
    this.size = AppConstants.circularButtonSize,
    this.backgroundColor = AppColors.textWhite,
    this.iconSize = 22.4,
    this.padding = AppConstants.smallPadding,
  }) : super(key: key);

  final String iconPath;
  final VoidCallback onTap;
  final double size;
  final Color backgroundColor;
  final double iconSize;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: SvgPicture.asset(
            iconPath,
            width: iconSize,
            height: iconSize,
          ),
        ),
      ),
    );
  }
}
