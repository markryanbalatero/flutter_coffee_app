import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/models/coffee_item.dart';

class FavoriteCubit extends Cubit<List<CoffeeItem>> {
  FavoriteCubit() : super([]);

  void addFavorite(CoffeeItem coffee) {
    if (!state.any((item) => item.id == coffee.id)) {
      emit([...state, coffee]);
    }
  }

  void removeFavorite(CoffeeItem coffee) {
    emit(state.where((item) => item.id != coffee.id).toList());
  }

  bool isFavorite(CoffeeItem coffee) {
    return state.any((item) => item.id == coffee.id);
  }
}
