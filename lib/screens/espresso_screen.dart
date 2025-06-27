import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../widgets/product/product_header.dart';
import '../widgets/sections/description_section.dart';
import '../widgets/sections/chocolate_selection_section.dart';
import '../widgets/sections/size_and_quantity_section.dart';
import '../widgets/sections/price_and_buy_section.dart';

class EspressoScreen extends StatefulWidget {
  const EspressoScreen({super.key});

  @override
  State<EspressoScreen> createState() => _EspressoScreenState();
}

class _EspressoScreenState extends State<EspressoScreen> {
  // State variables
  String selectedChocolate = 'White Chocolate';
  String selectedSize = 'S';
  int quantity = 1;
  bool isFavorite = false;

  // Base price and size multipliers
  static const double basePrice = 4.20;
  static const Map<String, double> sizeMultipliers = {
    'S': 1.0,   // Small: base price
    'M': 1.2,   // Medium: 20% more
    'L': 1.5,   // Large: 50% more
  };

  /// Calculates the total price based on size and quantity
  double get totalPrice {
    final sizeMultiplier = sizeMultipliers[selectedSize] ?? 1.0;
    return basePrice * sizeMultiplier * quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductHeader(
              onBackPressed: () => Navigator.pop(context),
              isFavorite: isFavorite,
              onFavoritePressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            ),
            _buildContentSection(context),
          ],
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
          const DescriptionSection(),
          const SizedBox(height: AppConstants.largeSpacing),
          ChocolateSelectionSection(
            selectedChocolate: selectedChocolate,
            onChocolateSelected: (chocolate) {
              setState(() => selectedChocolate = chocolate);
            },
          ),
          const SizedBox(height: AppConstants.largeSpacing),
          SizeAndQuantitySection(
            selectedSize: selectedSize,
            quantity: quantity,
            onSizeSelected: (size) {
              setState(() => selectedSize = size);
            },
            onQuantityChanged: (newQuantity) {
              setState(() => quantity = newQuantity);
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
