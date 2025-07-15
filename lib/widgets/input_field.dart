import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../theme/app_theme.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final double width;
  final double height;

  const InputField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.onChanged,
    this.width = 268,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.inputFieldBackground,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.inputBorderColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.inputShadowColor,
            blurRadius: 24,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.blue.withValues(alpha: 0.3),
            selectionHandleColor: Colors.blue,
          ),
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          style: AppTheme.inputTextStyle,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTheme.hintTextStyle,
            contentPadding: const EdgeInsets.only(
              left: 27,
              right: 20,
              top: 13,
              bottom: 13,
            ),
            filled: true,
            fillColor: AppColors.inputFieldBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
