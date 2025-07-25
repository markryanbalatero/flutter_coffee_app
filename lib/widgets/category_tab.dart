import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/app_colors.dart';
import '../theme/app_theme.dart';
import '../cubit/theme/theme_cubit.dart';

class CategoryTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryTab({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == ThemeMode.dark;

        return GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Column(
              children: [
                Text(
                  title,
                  style: isSelected
                      ? AppTheme.categoryTabSelectedStyle.copyWith(
                          color: isDarkMode 
                            ? AppColors.darkPrimary 
                            : null
                        )
                      : AppTheme.categoryTabUnselectedStyle.copyWith(
                          color: isDarkMode 
                            ? AppColors.darkOnSurface 
                            : null
                        ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (isDarkMode 
                            ? AppColors.darkPrimary 
                            : AppColors.categoryTabSelectedColor)
                        : AppColors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
