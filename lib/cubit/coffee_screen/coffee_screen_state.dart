import '../../core/models/coffee_item.dart';

/// Generic state class for coffee screens (can be used for different coffee types)
class CoffeeScreenState {
  final CoffeeItem? coffee;
  final bool isLoading;
  final String? errorMessage;
  final int quantity;
  final String selectedChocolate;
  final String selectedSize;
  final double totalPrice;
  final bool isImageViewerVisible;
  final bool isFavorite;
  final String screenType; // 'espresso', 'latte', 'cappuccino', etc.

  const CoffeeScreenState({
    this.coffee,
    this.isLoading = false,
    this.errorMessage,
    this.quantity = 1,
    this.selectedChocolate = 'White Chocolate',
    this.selectedSize = 'S',
    this.totalPrice = 0.0,
    this.isImageViewerVisible = false,
    this.isFavorite = false,
    this.screenType = 'espresso',
  });

  /// Creates a copy of the current state with updated values
  CoffeeScreenState copyWith({
    CoffeeItem? coffee,
    bool? isLoading,
    String? errorMessage,
    int? quantity,
    String? selectedChocolate,
    String? selectedSize,
    double? totalPrice,
    bool? isImageViewerVisible,
    bool? isFavorite,
    String? screenType,
  }) {
    return CoffeeScreenState(
      coffee: coffee ?? this.coffee,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      quantity: quantity ?? this.quantity,
      selectedChocolate: selectedChocolate ?? this.selectedChocolate,
      selectedSize: selectedSize ?? this.selectedSize,
      totalPrice: totalPrice ?? this.totalPrice,
      isImageViewerVisible: isImageViewerVisible ?? this.isImageViewerVisible,
      isFavorite: isFavorite ?? this.isFavorite,
      screenType: screenType ?? this.screenType,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CoffeeScreenState &&
        other.coffee == coffee &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage &&
        other.quantity == quantity &&
        other.selectedChocolate == selectedChocolate &&
        other.selectedSize == selectedSize &&
        other.totalPrice == totalPrice &&
        other.isImageViewerVisible == isImageViewerVisible &&
        other.isFavorite == isFavorite &&
        other.screenType == screenType;
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
        isImageViewerVisible.hashCode ^
        isFavorite.hashCode ^
        screenType.hashCode;
  }

  @override
  String toString() {
    return 'CoffeeScreenState(coffee: $coffee, isLoading: $isLoading, errorMessage: $errorMessage, quantity: $quantity, selectedChocolate: $selectedChocolate, selectedSize: $selectedSize, totalPrice: $totalPrice, isImageViewerVisible: $isImageViewerVisible, isFavorite: $isFavorite, screenType: $screenType)';
  }
}
