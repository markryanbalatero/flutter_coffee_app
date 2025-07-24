import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/app_colors.dart';
import '../theme/app_theme.dart';
import '../cubit/theme/theme_cubit.dart';

class SpecialOfferCard extends StatelessWidget {
  final String title;
  final String description;
  final double currentPrice;
  final double originalPrice;
  final String imageAsset;
  final VoidCallback? onTap;

  const SpecialOfferCard({
    super.key,
    required this.title,
    required this.description,
    required this.currentPrice,
    required this.originalPrice,
    this.imageAsset = 'assets/images/coffee_espresso.png',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == ThemeMode.dark;
        final theme = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTheme.specialOfferTitleStyle.copyWith(
                color: isDarkMode
                  ? AppColors.darkTextOnBackground
                  : null
              )
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: double.infinity,
                height: 145,
                decoration: BoxDecoration(
                  color: isDarkMode
                    ? AppColors.darkSurface
                    : AppColors.specialOfferCardBackground,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode
                        ? Colors.black.withOpacity(0.3)
                        : AppColors.specialOfferCardShadow,
                      blurRadius: 24,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: AssetImage(imageAsset),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              description,
                              style: AppTheme.specialOfferDescriptionStyle.copyWith(
                                color: isDarkMode
                                  ? AppColors.darkOnSurface
                                  : null
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text(
                                  '\$${currentPrice.toStringAsFixed(2)}',
                                  style: AppTheme.specialOfferPriceStyle.copyWith(
                                    color: isDarkMode
                                      ? AppColors.darkPrimary
                                      : null
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '\$${originalPrice.toStringAsFixed(1)}',
                                  style: AppTheme.specialOfferOriginalPriceStyle.copyWith(
                                    color: isDarkMode
                                      ? AppColors.darkOnSurface
                                      : null
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
