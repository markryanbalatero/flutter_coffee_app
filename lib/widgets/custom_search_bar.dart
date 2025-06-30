import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_colors.dart';
import '../theme/app_theme.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;
  final TextEditingController? controller;

  const CustomSearchBar({
    super.key,
    this.hintText = 'Find your coffee...',
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.searchBackground,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.searchBorder, width: 1),
        boxShadow: const [
          BoxShadow(
            color: AppColors.searchShadow,
            blurRadius: 24,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: AppTheme.searchBarTextStyle,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTheme.searchBarHintStyle,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 18, right: 10),
            child: SvgPicture.asset(
              'assets/icons/search.svg',
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(
                AppColors.searchIconColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 18,
          ),
          isDense: false,
        ),
      ),
    );
  }
}
