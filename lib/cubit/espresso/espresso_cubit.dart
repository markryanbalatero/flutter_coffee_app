import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/models/coffee_item.dart';
import 'espresso_state.dart';

/// Cubit for managing the Espresso screen state and business logic
class EspressoCubit extends Cubit<EspressoState> {
  EspressoCubit() : super(const EspressoState());

  // Size multipliers for price calculation
  static const Map<String, double> sizeMultipliers = {
    'S': 1.0, // Small: base price
    'M': 1.2, // Medium: 20% more
    'L': 1.5, // Large: 50% more
  };

  /// Initializes the espresso screen with coffee data
  void initializeEspresso(CoffeeItem coffee) {
    emit(
      state.copyWith(
        coffee: coffee,
        isLoading: false,
        totalPrice: _calculateTotalPrice(
          coffee.price,
          state.selectedSize,
          state.quantity,
        ),
      ),
    );
  }

  /// Updates the selected chocolate type
  void selectChocolate(String chocolate) {
    emit(state.copyWith(selectedChocolate: chocolate));
  }

  /// Updates the selected size and recalculates price
  void selectSize(String size) {
    if (state.coffee != null) {
      final newTotalPrice = _calculateTotalPrice(
        state.coffee!.price,
        size,
        state.quantity,
      );
      emit(state.copyWith(selectedSize: size, totalPrice: newTotalPrice));
    }
  }

  /// Updates the quantity and recalculates price
  void updateQuantity(int quantity) {
    if (quantity > 0 && state.coffee != null) {
      final newTotalPrice = _calculateTotalPrice(
        state.coffee!.price,
        state.selectedSize,
        quantity,
      );
      emit(state.copyWith(quantity: quantity, totalPrice: newTotalPrice));
    }
  }

  /// Toggles the favorite status of the coffee
  void toggleFavorite() {
    if (state.coffee != null) {
      final updatedCoffee = CoffeeItem(
        id: state.coffee!.id,
        name: state.coffee!.name,
        description: state.coffee!.description,
        price: state.coffee!.price,
        rating: state.coffee!.rating,
        image: state.coffee!.image,
        sizes: state.coffee!.sizes,
        sizePrices: state.coffee!.sizePrices,
        isFavorite: !state.coffee!.isFavorite,
      );

      emit(state.copyWith(coffee: updatedCoffee));
    }
  }

  /// Shows the image viewer
  void showImageViewer() {
    emit(state.copyWith(isImageViewerVisible: true));
  }

  /// Hides the image viewer
  void hideImageViewer() {
    emit(state.copyWith(isImageViewerVisible: false));
  }

  /// Sets loading state
  void setLoading(bool isLoading) {
    emit(state.copyWith(isLoading: isLoading));
  }

  /// Sets error message
  void setError(String? errorMessage) {
    emit(state.copyWith(errorMessage: errorMessage));
  }

  /// Handles buy now action
  void buyNow() {
    if (state.coffee != null && state.quantity > 0) {
      setLoading(true);

      // TODO: Implement actual buy logic here
      // For now, just simulate a purchase
      Future.delayed(const Duration(seconds: 2), () {
        setLoading(false);
        // You can emit success state or navigate to another screen
      });
    }
  }

  /// Calculates the total price based on base price, size, and quantity
  double _calculateTotalPrice(double basePrice, String size, int quantity) {
    final sizeMultiplier = sizeMultipliers[size] ?? 1.0;
    return basePrice * sizeMultiplier * quantity;
  }

  /// Gets available chocolate options
  List<String> get chocolateOptions => [
    'White Chocolate',
    'Milk Chocolate',
    'Dark Chocolate',
    'Bittersweet Chocolate',
    'Ruby Chocolate',
  ];

  /// Gets available size options
  List<String> get sizeOptions => ['S', 'M', 'L'];

  /// Checks if the current coffee has chocolate based on name/description
  bool get hasChocolate {
    if (state.coffee == null) return false;

    final lowerName = state.coffee!.name.toLowerCase();
    final lowerDesc = state.coffee!.description.toLowerCase();

    return lowerName.contains('chocolate') ||
        lowerDesc.contains('chocolate') ||
        lowerName.contains('mocha') ||
        lowerDesc.contains('mocha');
  }

  /// Gets the roast level based on coffee type
  String get roastLevel {
    if (state.coffee == null) return 'Medium Roasted';

    final lowerName = state.coffee!.name.toLowerCase();

    if (lowerName.contains('espresso')) {
      return 'Dark Roasted';
    } else if (lowerName.contains('latte') ||
        lowerName.contains('cappuccino')) {
      return 'Medium Roasted';
    } else if (lowerName.contains('americano') ||
        lowerName.contains('french')) {
      return 'Medium Roasted';
    } else {
      return 'Medium Roasted'; // Default
    }
  }
}
