import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import '../../core/models/coffee_item.dart';
import '../../services/firestore_service.dart';

class CoffeeStreamState {
  final List<CoffeeItem> coffees;
  final bool isLoading;
  final String? errorMessage;

  const CoffeeStreamState({
    this.coffees = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  CoffeeStreamState copyWith({
    List<CoffeeItem>? coffees,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CoffeeStreamState(
      coffees: coffees ?? this.coffees,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class CoffeeStreamCubit extends Cubit<CoffeeStreamState> {
  StreamSubscription<List<CoffeeItem>>? _coffeeSubscription;

  CoffeeStreamCubit() : super(const CoffeeStreamState());

  void startListening() {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      _coffeeSubscription = FirestoreService.getCoffeesStream().listen(
        (coffees) {
          emit(
            state.copyWith(
              coffees: coffees,
              isLoading: false,
              errorMessage: null,
            ),
          );
        },
        onError: (error) {
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: 'Stream error: ${error.toString()}',
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to start listening: ${e.toString()}',
        ),
      );
    }
  }

  void stopListening() {
    _coffeeSubscription?.cancel();
    _coffeeSubscription = null;
  }

  @override
  Future<void> close() {
    stopListening();
    return super.close();
  }
}
