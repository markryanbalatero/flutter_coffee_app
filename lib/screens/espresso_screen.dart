import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_app/core/models/coffee_item.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../cubit/product_details/product_details_cubit.dart';
import '../cubit/product_details/product_details_state_state.dart';
import '../widgets/product/product_header.dart';
import '../widgets/sections/description_section.dart';
import '../widgets/sections/chocolate_selection_section.dart';
import '../widgets/sections/size_and_quantity_section.dart';
import '../widgets/sections/price_and_buy_section.dart';

class EspressoScreen extends StatefulWidget {
  final CoffeeItem? product;

  const EspressoScreen({super.key, this.product});

  @override
  State<EspressoScreen> createState() => _EspressoScreenState();
}

class _EspressoScreenState extends State<EspressoScreen> {
  late ProductDetailsCubit cubit;

  @override
  initState() {
    super.initState();
    cubit = ProductDetailsCubit();
    cubit.initProductDetails(widget.product!);
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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocProvider(
        create: (context) => cubit,
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                builder: (context, state) {
                  return ProductHeader(
                      onBackPressed: () => Navigator.pop(context),
                      isFavorite: state.coffee?.isFavorite ?? false,
                      onFavoritePressed: () => cubit.toggleFavorite());
                },
              ),
              _buildContentSection(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the main content section
  Widget _buildContentSection(BuildContext context) {
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
            return DescriptionSection(state.coffee!);
          }),
          const SizedBox(height: AppConstants.largeSpacing),
          ChocolateSelectionSection(
            selectedChocolate: selectedChocolate,
            onChocolateSelected: (chocolate) {
              setState(() => selectedChocolate = chocolate);
            },
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
              );
            },
          ),
          const SizedBox(height: AppConstants.largeSpacing),
          PriceAndBuySection(
            price: totalPrice,
            onBuyNow: () {
              // TODO: Implement buy now functionality
            },
          ),
        ],
      ),
    );
  }
}
