import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import '../../core/models/coffee_item.dart';
import '../../services/firestore_service.dart';

class CoffeeState {
  final List<CoffeeItem> coffees;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const CoffeeState({
    this.coffees = const [],
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  CoffeeState copyWith({
    List<CoffeeItem>? coffees,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return CoffeeState(
      coffees: coffees ?? this.coffees,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class CoffeeCubit extends Cubit<CoffeeState> {
  CoffeeCubit() : super(const CoffeeState());

  Future<void> loadCoffees() async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      
      final coffees = await FirestoreService.getAllCoffees();
      
      emit(state.copyWith(
        coffees: coffees,
        isLoading: false,
        isSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load coffees: ${e.toString()}',
      ));
    }
  }

  Future<void> addCoffee({
    required CoffeeItem coffee,
    File? imageFile,
  }) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      
      await FirestoreService.addCoffee(
        coffee: coffee,
        imageFile: imageFile,
      );
      
      await loadCoffees();
      
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to add coffee: ${e.toString()}',
      ));
    }
  }

  Future<void> updateCoffee({
    required String coffeeId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      
      await FirestoreService.updateCoffee(
        coffeeId: coffeeId,
        updates: updates,
      );
      
      await loadCoffees();
      
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to update coffee: ${e.toString()}',
      ));
    }
  }

  Future<void> deleteCoffee(String coffeeId) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      
      await FirestoreService.deleteCoffee(coffeeId);
      
      await loadCoffees();
      
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to delete coffee: ${e.toString()}',
      ));
    }
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }

  void resetState() {
    emit(const CoffeeState());
  }
}
