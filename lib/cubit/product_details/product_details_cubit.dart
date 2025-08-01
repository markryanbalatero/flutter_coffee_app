import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/models/coffee_item.dart';
import 'product_details_state_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsState());

  void initProductDetails(CoffeeItem product) {
    emit(state.copyWith(
      coffee: product,
      isLoading: false,
      selectedSize: product.sizes.isNotEmpty ? product.sizes.first : 'S',
      totalPrice: product.price,
    ));
  }

  void setQty(int quantity) {
    emit(state.copyWith(
      quantity: quantity,
      totalPrice: _calculateTotalPrice(
          state.coffee?.price ?? 0.0, state.selectedSize, quantity),
    ));
  }

  void setChocolate(String chocolate) {
    emit(state.copyWith(selectedChocolate: chocolate));
  }

  void setSize(String size) {
    emit(state.copyWith(
      selectedSize: size,
      totalPrice: _calculateTotalPrice(
          state.coffee?.price ?? 0.0, size, state.quantity),
    ));
  }

  double _calculateTotalPrice(double basePrice, String size, int quantity) {
    // You can add your size multiplier logic here
    double multiplier = 1.0;
    if (size == 'M') multiplier = 1.2;
    if (size == 'L') multiplier = 1.5;
    return basePrice * multiplier * quantity;
  }

  void toggleFavorite() {
    final coffee = state.coffee;
    if (coffee != null) {
      coffee.isFavorite = !coffee.isFavorite;
      emit(state.copyWith(coffee: coffee));
    }
  }
}
