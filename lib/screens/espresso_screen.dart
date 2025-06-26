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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductHeader(
              onBackPressed: () => Navigator.pop(context),
              onFavoritePressed: () {
                // TODO: Implement favorite functionality
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
            price: double.parse(AppConstants.productPrice),
            onBuyNow: () {
              // TODO: Implement buy now functionality
            },
          ),
        ],
      ),
    );
  }
}