import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// A custom primary button with rounded corners
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 40, // Default reduced height
    this.width = double.infinity, // Default to fill available width
    this.backgroundColor = AppColors.primary,
    this.textColor,
    this.textStyle = AppTextStyles.buttonText,
    this.borderRadius = AppConstants.smallBorderRadius,
    this.isLoading = false,
    this.isEnabled = true,
  });

  final String text;
  final VoidCallback? onPressed;
  final double height;
  final double width;
  final Color backgroundColor;
  final Color? textColor;
  final TextStyle textStyle;
  final double borderRadius;
  final bool isLoading;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width, // Explicitly set the width
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(width, height), // Ensure minimum size matches
          backgroundColor: backgroundColor,
          disabledBackgroundColor: AppColors.buttonInactive,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
          padding: EdgeInsets.zero, // Remove default padding
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.textWhite),
                ),
              )
            : Text(
                text, 
                style: textStyle.copyWith(
                  color: textColor ?? textStyle.color
                ),
                overflow: TextOverflow.ellipsis,
              ),
      ),
    );
  }
}
