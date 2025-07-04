import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/models/coffee_item.dart';
import 'coffee_screen_state.dart';

/// Generic cubit for managing coffee screen state (reusable for different coffee types)
class CoffeeScreenCubit extends Cubit<CoffeeScreenState> {
  CoffeeScreenCubit({String screenType = 'espresso'})
    : super(CoffeeScreenState(screenType: screenType));

  // Size multipliers for price calculation
  static const Map<String, double> sizeMultipliers = {
    'S': 1.0, // Small: base price
    'M': 1.2, // Medium: 20% more
    'L': 1.5, // Large: 50% more
  };

  /// Initializes the coffee screen with coffee data
  void initializeCoffeeScreen(CoffeeItem coffee) {
    emit(
      state.copyWith(
        coffee: coffee,
        isLoading: false,
        isFavorite: coffee.isFavorite,
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
      final currentCoffee = state.coffee!;
      currentCoffee.isFavorite = !currentCoffee.isFavorite;

      emit(
        state.copyWith(
          coffee: currentCoffee,
          isFavorite: currentCoffee.isFavorite,
        ),
      );
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
  Future<void> buyNow() async {
    if (state.coffee != null && state.quantity > 0) {
      setLoading(true);

      try {
        // TODO: Implement actual buy logic here
        // For now, just simulate a purchase
        await Future.delayed(const Duration(seconds: 2));

        setLoading(false);
        // You can emit success state or navigate to another screen
      } catch (e) {
        setLoading(false);
        setError('Failed to complete purchase: ${e.toString()}');
      }
    }
  }

  /// Calculates the total price based on base price, size, and quantity
  double _calculateTotalPrice(double basePrice, String size, int quantity) {
    final sizeMultiplier = sizeMultipliers[size] ?? 1.0;
    return basePrice * sizeMultiplier * quantity;
  }

  /// Gets available chocolate options based on coffee type
  List<String> get chocolateOptions {
    switch (state.screenType) {
      case 'mocha':
        return [
          'Dark Chocolate',
          'Milk Chocolate',
          'White Chocolate',
          'Bittersweet Chocolate',
        ];
      case 'cappuccino':
        return [
          'White Chocolate',
          'Milk Chocolate',
          'Dark Chocolate',
          'Cinnamon',
        ];
      default:
        return [
          'White Chocolate',
          'Milk Chocolate',
          'Dark Chocolate',
          'Bittersweet Chocolate',
          'Ruby Chocolate',
        ];
    }
  }

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
        lowerDesc.contains('mocha') ||
        state.screenType == 'mocha';
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
    } else if (state.screenType == 'espresso') {
      return 'Dark Roasted';
    } else {
      return 'Medium Roasted'; // Default
    }
  }

  /// Gets coffee-specific recommendations
  List<String> get recommendations {
    switch (state.screenType) {
      case 'espresso':
        return [
          'Perfect for morning boost',
          'Intense flavor',
          'Quick preparation',
        ];
      case 'latte':
        return [
          'Smooth and creamy',
          'Perfect with breakfast',
          'Mild coffee taste',
        ];
      case 'cappuccino':
        return ['Rich foam texture', 'Balanced flavor', 'Italian classic'];
      case 'mocha':
        return ['Chocolate lovers choice', 'Sweet and rich', 'Dessert-like'];
      default:
        return ['Great coffee choice', 'Enjoy your drink'];
    }
  }
}
