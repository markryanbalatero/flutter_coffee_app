import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/app_colors.dart';
import '../theme/app_theme.dart';
import '../cubit/theme/theme_cubit.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final VoidCallback? onAddTapped;

  const CustomBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    this.onAddTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == ThemeMode.dark;
        final theme = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

        return Container(
          decoration: BoxDecoration(
            color: isDarkMode 
              ? AppColors.darkSurface 
              : AppColors.bottomNavigationBackground,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: isDarkMode 
                  ? Colors.black.withOpacity(0.3) 
                  : AppColors.bottomNavigationShadow,
                blurRadius: 24,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(context, 'assets/icons/home.svg', 0, isDarkMode),
                  _buildNavItem(context, 'assets/icons/heart.svg', 1, isDarkMode),
                  _buildAddButton(context, isDarkMode),
                  _buildNavItem(context, 'assets/icons/notification.svg', 3, isDarkMode),
                  _buildNavItem(context, 'assets/icons/profile.svg', 4, isDarkMode),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddButton(BuildContext context, bool isDarkMode) {
    return GestureDetector(
      onTap: onAddTapped,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: isDarkMode 
            ? AppColors.darkPrimary 
            : AppColors.buttonColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.add, 
          color: isDarkMode 
            ? AppColors.darkOnPrimary 
            : Colors.white, 
          size: 24
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String iconPath, int index, bool isDarkMode) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected
              ? (isDarkMode 
                  ? AppColors.darkPrimary.withOpacity(0.2) 
                  : AppColors.bottomNavigationSelectedBackground)
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              isSelected
                  ? (isDarkMode 
                      ? AppColors.darkPrimary 
                      : AppColors.bottomNavigationSelectedIcon)
                  : (isDarkMode 
                      ? AppColors.darkOnSurface 
                      : AppColors.bottomNavigationUnselectedIcon),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
