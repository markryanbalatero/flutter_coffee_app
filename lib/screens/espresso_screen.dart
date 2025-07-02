import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_app/core/models/coffee_item.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../cubit/espresso/espresso_cubit.dart';
import '../cubit/espresso/espresso_state.dart';
import '../widgets/product/product_header.dart';
import '../widgets/sections/description_section.dart';
import '../widgets/sections/chocolate_selection_section.dart';
import '../widgets/sections/size_and_quantity_section.dart';
import '../widgets/sections/price_and_buy_section.dart';
import '../widgets/dialogs/image_viewer_dialog.dart';

class EspressoScreen extends StatefulWidget {
  final CoffeeItem? product;

  const EspressoScreen({super.key, this.product});

  @override
  State<EspressoScreen> createState() => _EspressoScreenState();
}

class _EspressoScreenState extends State<EspressoScreen> {
  late EspressoCubit _espressoCubit;

  @override
  void initState() {
    super.initState();
    _espressoCubit = EspressoCubit();
    if (widget.product != null) {
      _espressoCubit.initializeEspresso(widget.product!);
    }
  }

  @override
  void dispose() {
    _espressoCubit.close();
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
      body: BlocProvider<EspressoCubit>(
        create: (context) => _espressoCubit,
        child: BlocBuilder<EspressoCubit, EspressoState>(
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
                    onFavoritePressed: () => _espressoCubit.toggleFavorite(),
                    coffee: state.coffee!,
                    onImageTap: () => _showImageViewer(context, state.coffee!),
                  ),
                  _buildContentSection(context, state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Builds the main content section
  Widget _buildContentSection(BuildContext context, EspressoState state) {
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
          ChocolateSelectionSection(
            selectedChocolate: state.selectedChocolate,
            onChocolateSelected: (chocolate) {
              _espressoCubit.selectChocolate(chocolate);
            },
          ),
          const SizedBox(height: AppConstants.largeSpacing),
          SizeAndQuantitySection(
            selectedSize: state.selectedSize,
            quantity: state.quantity,
            onSizeSelected: (size) {
              _espressoCubit.selectSize(size);
            },
            onQuantityChanged: (newQuantity) =>
                _espressoCubit.updateQuantity(newQuantity),
          ),
          const SizedBox(height: AppConstants.largeSpacing),
          PriceAndBuySection(
            price: state.totalPrice,
            onBuyNow: () {
              _espressoCubit.buyNow();
            },
          ),
        ],
      ),
    );
  }
}
