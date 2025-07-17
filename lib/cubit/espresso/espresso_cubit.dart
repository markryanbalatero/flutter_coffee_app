import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/models/coffee_item.dart';
import 'espresso_state.dart';

class EspressoCubit extends Cubit<EspressoState> {
  EspressoCubit() : super(const EspressoState());

  static const Map<String, double> sizeMultipliers = {
    'S': 1.0,
    'M': 1.2, 
    'L': 1.5, 
  };

  void initializeEspresso(CoffeeItem coffee) {
    if (isClosed) return;

    final defaultSize = coffee.sizes.isNotEmpty ? coffee.sizes.first : 'S';

    emit(
      state.copyWith(
        coffee: coffee,
        isLoading: false,
        selectedSize: defaultSize,
        totalPrice: _calculateTotalPrice(
          coffee.price,
          defaultSize,
          state.quantity,
        ),
      ),
    );
  }
  void selectChocolate(String chocolate) {
    if (isClosed) return;
    emit(state.copyWith(selectedChocolate: chocolate));
  }

  void selectSize(String size) {
    if (isClosed) return;
    if (state.coffee != null) {
      final newTotalPrice = _calculateTotalPrice(
        state.coffee!.price,
        size,
        state.quantity,
      );
      emit(state.copyWith(selectedSize: size, totalPrice: newTotalPrice));
    }
  }

  void updateQuantity(int quantity) {
    if (isClosed) return;
    if (quantity > 0 && state.coffee != null) {
      final newTotalPrice = _calculateTotalPrice(
        state.coffee!.price,
        state.selectedSize,
        quantity,
      );
      emit(state.copyWith(quantity: quantity, totalPrice: newTotalPrice));
    }
  }

  void toggleFavorite() {
    if (isClosed) return;
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
        category: state.coffee!.category,
        isFavorite: !state.coffee!.isFavorite,
      );

      emit(state.copyWith(coffee: updatedCoffee));
    }
  }

  void showImageViewer() {
    if (isClosed) return;
    emit(state.copyWith(isImageViewerVisible: true));
  }

  void hideImageViewer() {
    if (isClosed) return;
    emit(state.copyWith(isImageViewerVisible: false));
  }

  void setLoading(bool isLoading) {
    if (isClosed) return;
    emit(state.copyWith(isLoading: isLoading));
  }

  void setError(String? errorMessage) {
    if (isClosed) return;
    emit(state.copyWith(errorMessage: errorMessage));
  }

  void buyNow() {
    if (isClosed) return;
    if (state.coffee != null && state.quantity > 0) {
      setLoading(true);

      Future.delayed(const Duration(seconds: 2), () {
        if (!isClosed) {
          setLoading(false);
        }
      });
    }
  }

  double _calculateTotalPrice(double basePrice, String size, int quantity) {
    if (state.coffee != null && state.coffee!.sizePrices.containsKey(size)) {
      return state.coffee!.sizePrices[size]! * quantity;
    }

    final sizeMultiplier = sizeMultipliers[size] ?? 1.0;
    return basePrice * sizeMultiplier * quantity;
  }

  List<String> get chocolateOptions => [
        'White Chocolate',
        'Milk Chocolate',
        'Dark Chocolate',
        'Bittersweet Chocolate',
        'Ruby Chocolate',
      ];

  List<String> get sizeOptions {
    if (state.coffee != null && state.coffee!.sizes.isNotEmpty) {
      return state.coffee!.sizes;
    }
    return ['S', 'M', 'L'];
  }

  bool get hasChocolate {
    if (state.coffee == null) return false;

    final lowerName = state.coffee!.name.toLowerCase();
    final lowerDesc = state.coffee!.description.toLowerCase();

    return lowerName.contains('chocolate') ||
        lowerDesc.contains('chocolate') ||
        lowerName.contains('mocha') ||
        lowerDesc.contains('mocha');
  }

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
      return 'Medium Roasted'; 
    }
  }
}
