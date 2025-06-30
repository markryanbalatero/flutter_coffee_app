import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// A custom primary button with rounded corners
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.height = AppConstants.buyButtonHeight,
    this.backgroundColor = AppColors.primary,
    this.textStyle = AppTextStyles.buttonText,
    this.borderRadius = AppConstants.smallBorderRadius,
    this.isLoading = false,
    this.isEnabled = true,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final double height;
  final Color backgroundColor;
  final TextStyle textStyle;
  final double borderRadius;
  final bool isLoading;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: AppColors.buttonInactive,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.textWhite),
                ),
              )
            : Text(text, style: textStyle),
      ),
    );
  }
}
