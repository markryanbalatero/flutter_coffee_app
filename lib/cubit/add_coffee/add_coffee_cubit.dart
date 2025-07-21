import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import '../../core/models/coffee_item.dart';
import '../../services/firestore_service.dart';

class AddCoffeeState {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;
  final String selectedChocolate;
  final String selectedSize;
  final String selectedCategory;
  final int quantity;
  final File? selectedImage;

  const AddCoffeeState({
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
    this.selectedChocolate = 'Milk',
    this.selectedSize = 'S',
    this.selectedCategory = 'espresso',
    this.quantity = 1,
    this.selectedImage,
  });

  AddCoffeeState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    String? selectedChocolate,
    String? selectedSize,
    String? selectedCategory,
    int? quantity,
    File? selectedImage,
  }) {
    return AddCoffeeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      selectedChocolate: selectedChocolate ?? this.selectedChocolate,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      quantity: quantity ?? this.quantity,
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }
}

class AddCoffeeCubit extends Cubit<AddCoffeeState> {
  AddCoffeeCubit() : super(const AddCoffeeState());

  Future<void> addCoffee({
    required String name,
    required String description,
    required double price,
  }) async {
    print('Starting addCoffee process...');
    print(
      'Coffee details: $name, $description, \$${price.toStringAsFixed(2)}',
    );
    if (state.selectedImage == null) {
      print('No image selected');
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Please select an image before adding the coffee',
        ),
      );
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      print('Selected image: ${state.selectedImage?.path}');

    
      if (state.selectedImage != null && !await state.selectedImage!.exists()) {
        throw Exception('Selected image file no longer exists');
      }

      final coffeeId = DateTime.now().millisecondsSinceEpoch.toString();
      print('Generated coffee ID: $coffeeId');

      final newCoffee = CoffeeItem(
        id: coffeeId,
        name: name,
        description: description,
        price: price,
        image: '', 
        rating: 0.0,
        isFavorite: false,
        sizes: ['S', 'M', 'L'],
        sizePrices: {'S': price, 'M': price + 1.0, 'L': price + 2.0},
        category: state.selectedCategory,
      );

      print('Created coffee item: ${newCoffee.toJson()}');

      final addedCoffeeId = await FirestoreService.addCoffee(
        coffee: newCoffee,
        imageFile: state.selectedImage,
      );

      print('Coffee successfully added to Firestore with ID: $addedCoffeeId');

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      print('Error adding coffee: $e');
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to add coffee: ${e.toString()}',
        ),
      );
    }
  }

  void resetState() {
    emit(const AddCoffeeState());
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }

  void selectChocolate(String chocolate) {
    emit(state.copyWith(selectedChocolate: chocolate));
  }

  void selectSize(String size) {
    emit(state.copyWith(selectedSize: size));
  }

  void selectCategory(String category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void incrementQuantity() {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void decrementQuantity() {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }

  void selectImage(File image) {
    emit(state.copyWith(selectedImage: image));
  }
}
