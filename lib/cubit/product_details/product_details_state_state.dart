import '../../core/models/coffee_item.dart';

class ProductDetailsState {
  final CoffeeItem? coffee;
  final bool isLoading;
  final String? errorMessage;
  final int quantity;

  ProductDetailsState({
    this.coffee,
    this.isLoading = false,
    this.errorMessage,
    this.quantity = 1,
  });

  ProductDetailsState copyWith({
    CoffeeItem? coffee,
    bool? isLoading,
    String? errorMessage,
    int? quantity,
  }) {
    return ProductDetailsState(
      coffee: coffee ?? this.coffee,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      quantity: quantity ?? this.quantity,
    );
  }
}
