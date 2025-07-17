import '../../core/models/coffee_item.dart';

class EspressoState {
  final CoffeeItem? coffee;
  final bool isLoading;
  final String? errorMessage;
  final int quantity;
  final String selectedChocolate;
  final String selectedSize;
  final double totalPrice;
  final bool isImageViewerVisible;

  const EspressoState({
    this.coffee,
    this.isLoading = false,
    this.errorMessage,
    this.quantity = 1,
    this.selectedChocolate = 'White Chocolate',
    this.selectedSize = 'S',
    this.totalPrice = 0.0,
    this.isImageViewerVisible = false,
  });

  EspressoState copyWith({
    CoffeeItem? coffee,
    bool? isLoading,
    String? errorMessage,
    int? quantity,
    String? selectedChocolate,
    String? selectedSize,
    double? totalPrice,
    bool? isImageViewerVisible,
  }) {
    return EspressoState(
      coffee: coffee ?? this.coffee,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      quantity: quantity ?? this.quantity,
      selectedChocolate: selectedChocolate ?? this.selectedChocolate,
      selectedSize: selectedSize ?? this.selectedSize,
      totalPrice: totalPrice ?? this.totalPrice,
      isImageViewerVisible: isImageViewerVisible ?? this.isImageViewerVisible,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EspressoState &&
        other.coffee == coffee &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage &&
        other.quantity == quantity &&
        other.selectedChocolate == selectedChocolate &&
        other.selectedSize == selectedSize &&
        other.totalPrice == totalPrice &&
        other.isImageViewerVisible == isImageViewerVisible;
  }

  @override
  int get hashCode {
    return coffee.hashCode ^
        isLoading.hashCode ^
        errorMessage.hashCode ^
        quantity.hashCode ^
        selectedChocolate.hashCode ^
        selectedSize.hashCode ^
        totalPrice.hashCode ^
        isImageViewerVisible.hashCode;
  }

  @override
  String toString() {
    return 'EspressoState(coffee: $coffee, isLoading: $isLoading, errorMessage: $errorMessage, quantity: $quantity, selectedChocolate: $selectedChocolate, selectedSize: $selectedSize, totalPrice: $totalPrice, isImageViewerVisible: $isImageViewerVisible)';
  }
}
