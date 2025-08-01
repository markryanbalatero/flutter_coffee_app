import '../../core/models/coffee_item.dart';

class ProductDetailsState {
  final CoffeeItem? coffee;
  final bool isLoading;
  final String? errorMessage;
  final int quantity;
  final String selectedChocolate;
  final String selectedSize;
  final double totalPrice;

  ProductDetailsState({
    this.coffee,
    this.isLoading = false,
    this.errorMessage,
    this.quantity = 1,
    this.selectedChocolate = 'White Chocolate',
    this.selectedSize = 'S',
    this.totalPrice = 0.0,
  });

  ProductDetailsState copyWith({
    CoffeeItem? coffee,
    bool? isLoading,
    String? errorMessage,
    int? quantity,
    String? selectedChocolate,
    String? selectedSize,
    double? totalPrice,
  }) {
    return ProductDetailsState(
      coffee: coffee ?? this.coffee,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      quantity: quantity ?? this.quantity,
      selectedChocolate: selectedChocolate ?? this.selectedChocolate,
      selectedSize: selectedSize ?? this.selectedSize,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
