import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/models/coffee_item.dart';
import 'product_details_state_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsState());

  void initProductDetails(CoffeeItem product) {
    emit(state.copyWith(coffee: product, isLoading: false));
  }

  void setQty(int quantity) {
    emit(state.copyWith(
      quantity: quantity,
    ));
  }

  void toggleFavorite() {
    final coffee = state.coffee;
    coffee!.isFavorite = !coffee.isFavorite;

    emit(state.copyWith(
      coffee: coffee,
    ));
  }
}
