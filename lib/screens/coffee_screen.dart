import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_app/core/models/coffee_item.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../cubit/coffee_screen/coffee_screen_cubit.dart';
import '../cubit/coffee_screen/coffee_screen_state.dart';
import '../widgets/product/product_header.dart';
import '../widgets/sections/description_section.dart';
import '../widgets/sections/chocolate_selection_section.dart';
import '../widgets/sections/size_and_quantity_section.dart';
import '../widgets/sections/price_and_buy_section.dart';
import '../widgets/dialogs/image_viewer_dialog.dart';

/// Generic coffee screen that can be used for different coffee types
class CoffeeScreen extends StatefulWidget {
  final CoffeeItem coffee;
  final String screenType; // 'latte', 'cappuccino', 'americano', etc.

  const CoffeeScreen({
    super.key,
    required this.coffee,
    this.screenType = 'coffee',
  });

  @override
  State<CoffeeScreen> createState() => _CoffeeScreenState();
}

class _CoffeeScreenState extends State<CoffeeScreen> {
  late CoffeeScreenCubit _coffeeScreenCubit;

  @override
  void initState() {
    super.initState();
    _coffeeScreenCubit = CoffeeScreenCubit(screenType: widget.screenType);
    _coffeeScreenCubit.initializeCoffeeScreen(widget.coffee);
  }

  @override
  void dispose() {
    _coffeeScreenCubit.close();
    super.dispose();
  }

  /// Shows the image viewer dialog when the coffee image is tapped
  void _showImageViewer(BuildContext context, CoffeeItem coffee) {
    ImageViewerDialog.show(context, coffee, coffee.image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocProvider<CoffeeScreenCubit>(
        create: (context) => _coffeeScreenCubit,
        child: BlocBuilder<CoffeeScreenCubit, CoffeeScreenState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.coffee == null) {
              return const Center(child: Text('No coffee data available'));
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  ProductHeader(
                    onBackPressed: () => Navigator.pop(context),
                    isFavorite: state.coffee!.isFavorite,
                    onFavoritePressed: () =>
                        _coffeeScreenCubit.toggleFavorite(),
                    coffee: state.coffee!,
                    onImageTap: () => _showImageViewer(context, state.coffee!),
                  ),
                  _buildContentSection(context, state),
                  if (state.errorMessage != null)
                    _buildErrorMessage(state.errorMessage!),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Builds the main content section
  Widget _buildContentSection(BuildContext context, CoffeeScreenState state) {
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
          DescriptionSection(state.coffee!),
          const SizedBox(height: AppConstants.largeSpacing),

          // Show recommendations for this coffee type
          _buildRecommendationsSection(state),
          const SizedBox(height: AppConstants.largeSpacing),

          ChocolateSelectionSection(
            selectedChocolate: state.selectedChocolate,
            onChocolateSelected: (chocolate) {
              _coffeeScreenCubit.selectChocolate(chocolate);
            },
          ),
          const SizedBox(height: AppConstants.largeSpacing),
          SizeAndQuantitySection(
            selectedSize: state.selectedSize,
            quantity: state.quantity,
            onSizeSelected: (size) {
              _coffeeScreenCubit.selectSize(size);
            },
            onQuantityChanged: (newQuantity) =>
                _coffeeScreenCubit.updateQuantity(newQuantity),
          ),
          const SizedBox(height: AppConstants.largeSpacing),
          PriceAndBuySection(
            price: state.totalPrice,
            onBuyNow: () {
              _coffeeScreenCubit.buyNow();
            },
          ),
        ],
      ),
    );
  }

  /// Builds the recommendations section
  Widget _buildRecommendationsSection(CoffeeScreenState state) {
    final recommendations = _coffeeScreenCubit.recommendations;

    if (recommendations.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.recommendationBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why choose ${state.coffee?.name}?',
            style: AppTheme.recommendationTitleStyle,
          ),
          const SizedBox(height: 8),
          ...recommendations
              .map(
                (recommendation) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          recommendation,
                          style: AppTheme.recommendationTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  /// Builds error message widget
  Widget _buildErrorMessage(String errorMessage) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.errorBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.errorBorder),
      ),
      child: Row(
        children: [
          Icon(Icons.error, color: AppColors.errorIcon),
          const SizedBox(width: 8),
          Expanded(child: Text(errorMessage, style: AppTheme.errorTextStyle)),
        ],
      ),
    );
  }
}
