import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String text;
  final IconData? icon;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;

  const CustomButton({
    Key? key,
    required this.onPressed,
    this.isLoading = false,
    this.text = 'Dive In',
    this.icon = Icons.arrow_forward,
    this.width = 158,
    this.height = 60,
    this.backgroundColor = AppTheme.buttonColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 6),
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          elevation: 0,
          minimumSize: Size(width, height - 10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: textColor,
                  strokeWidth: 2.0,
                ),
              )
            else
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                  color: textColor,
                ),
              ),
            const SizedBox(width: 10),
            if (!isLoading && icon != null) Icon(icon, size: 18),
          ],
        ),
      ),
    );
  }
}