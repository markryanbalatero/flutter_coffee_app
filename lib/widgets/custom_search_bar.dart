import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/app_colors.dart';
import '../theme/app_theme.dart';
import '../cubit/theme/theme_cubit.dart';

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
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == ThemeMode.dark;
        final theme = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
        
        return Container(
          height: 50,
          decoration: BoxDecoration(
            color: theme.inputDecorationTheme.fillColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isDarkMode 
                ? AppColors.darkDivider 
                : AppColors.searchBorder, 
              width: 1
            ),
            boxShadow: [
              BoxShadow(
                color: isDarkMode 
                  ? Colors.black.withOpacity(0.3)  
                  : AppColors.searchShadow,
                blurRadius: 24,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            style: TextStyle(
              color: theme.textTheme.bodyMedium?.color,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: isDarkMode 
                  ? AppColors.darkOnSurface 
                  : AppColors.searchHintColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 18, right: 10),
                child: SvgPicture.asset(
                  'assets/icons/search.svg',
                  width: 18,
                  height: 18,
                  colorFilter: ColorFilter.mode(
                    isDarkMode 
                      ? AppColors.darkOnSurface 
                      : AppColors.searchIconColor,
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
      },
    );
  }
}
