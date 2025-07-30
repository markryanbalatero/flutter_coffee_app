import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_app/core/models/coffee_item.dart';
import '../core/constants/app_constants.dart';
import '../utils/app_colors.dart';
import '../theme/app_theme.dart';
import '../cubit/theme/theme_cubit.dart';
import '../cubit/product_details/product_details_cubit.dart';
import '../cubit/product_details/product_details_state_state.dart';
import '../widgets/product/product_header.dart';
import '../widgets/sections/description_section.dart';
import '../widgets/sections/chocolate_selection_section.dart';
import '../widgets/sections/size_and_quantity_section.dart';
import '../widgets/sections/price_and_buy_section.dart';
import '../cubit/favorite_cubit.dart';

class EspressoScreen extends StatefulWidget {
  final CoffeeItem? product;

  const EspressoScreen({super.key, this.product});

  @override
  State<EspressoScreen> createState() => _EspressoScreenState();
}

class _EspressoScreenState extends State<EspressoScreen> {
  late ProductDetailsCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = ProductDetailsCubit();
    if (widget.product != null) {
      cubit.initProductDetails(widget.product!);
    }
  }

  // State variables
  String selectedChocolate = 'White Chocolate';
  String selectedSize = 'S';
  bool isFavorite = false;

  // Base price and size multipliers
  static const double basePrice = 4.20;
  static const Map<String, double> sizeMultipliers = {
    'S': 1.0, // Small: base price
    'M': 1.2, // Medium: 20% more
    'L': 1.5, // Large: 50% more
  };

  /// Calculates the total price based on size and quantity
  double get totalPrice {
    final sizeMultiplier = sizeMultipliers[selectedSize] ?? 1.0;
    return basePrice * sizeMultiplier * 1;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.product == null) {
      return Scaffold(
        backgroundColor: AppColors.dashboardBackground,
        body: Center(child: Text('No coffee data provided')),
      );
    }

    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == ThemeMode.dark;

        return Scaffold(
          backgroundColor: isDarkMode
              ? AppColors.darkBackground
              : AppColors.dashboardBackground,
          body: BlocProvider(
            create: (context) => cubit,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                    builder: (context, state) {
                      if (state.coffee == null) {
                        return const SizedBox.shrink();
                      }
                      return BlocBuilder<FavoriteCubit, List<CoffeeItem>>(
                        builder: (context, favorites) {
                          final favoriteCubit = context.read<FavoriteCubit>();
                          final isFav = favoriteCubit.isFavorite(state.coffee!);
                          return ProductHeader(
                            onBackPressed: () => Navigator.pop(context),
                            isFavorite: isFav,
                            onFavoritePressed: () async {
                              if (isFav) {
                                await favoriteCubit.removeFavorite(state.coffee!);
                              } else {
                                await favoriteCubit.addFavorite(state.coffee!);
                              }
                              setState(() {}); // update heart state
                            },
                            coffee: state.coffee!,
                          );
                        },
                      );
                    },
                  ),
                  _buildContentSection(context, isDarkMode),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Builds the main content section
  Widget _buildContentSection(BuildContext context, bool isDarkMode) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 200,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      padding: const EdgeInsets.fromLTRB(
        AppConstants.defaultPadding,
        20,
        AppConstants.defaultPadding,
        20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, state) {
            return DescriptionSection(state.coffee!, isDarkMode: isDarkMode);
          }),
          const SizedBox(height: AppConstants.largeSpacing),
          ChocolateSelectionSection(
            selectedChocolate: selectedChocolate,
            onChocolateSelected: (chocolate) {
              setState(() => selectedChocolate = chocolate);
            },
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: AppConstants.largeSpacing),
          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
            builder: (context, state) {
              return SizeAndQuantitySection(
                selectedSize: selectedSize,
                quantity: state.quantity,
                onSizeSelected: (size) {
                  setState(() => selectedSize = size);
                },
                onQuantityChanged: (newQuantity) => cubit.setQty(newQuantity),
                isDarkMode: isDarkMode,
              );
            },
          ),
          const SizedBox(height: AppConstants.largeSpacing),
          PriceAndBuySection(
            price: totalPrice,
            onBuyNow: () {
              // TODO: Implement buy now functionality
            },
            isDarkMode: isDarkMode,
          ),
        ],
      ),
    );
  }
}
