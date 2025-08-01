import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/models/coffee_item.dart';

enum FavoriteSortOrder { ascending, descending }

class FavoriteCubit extends Cubit<List<CoffeeItem>> {
  FavoriteSortOrder _sortOrder = FavoriteSortOrder.ascending;
  String _searchQuery = '';

  FavoriteSortOrder get sortOrder => _sortOrder;
  String get searchQuery => _searchQuery;

  // Returns the filtered and sorted favorites
  List<CoffeeItem> get filteredFavorites {
    final filtered = _searchQuery.isEmpty
        ? state
        : state
            .where((coffee) => coffee.name
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
            .toList();
    return _applySort(filtered);
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? _userId = FirebaseAuth.instance.currentUser?.uid;

  FavoriteCubit() : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    if (_userId == null) return;
    final snapshot = await _firestore
        .collection('coffees')
        .doc(_userId)
        .collection('favorites')
        .where('isFavorite', isEqualTo: true)
        .get();

    final favorites = snapshot.docs.map((doc) {
      final data = doc.data();
      return CoffeeItem.fromJson(data);
    }).toList();

    emit(_applySort(favorites));
  }

  Future<void> addFavorite(CoffeeItem coffee) async {
    if (_userId == null) return;
    await _firestore
        .collection('coffees')
        .doc(_userId)
        .collection('favorites')
        .doc(coffee.id)
        .set({...coffee.toJson(), 'isFavorite': true});
    // Only add to local state if not already present
    if (!state.any((item) => item.id == coffee.id)) {
      final updated = [...state, coffee];
      emit(_applySort(updated));
    }
  }

  Future<void> removeFavorite(CoffeeItem coffee) async {
    if (_userId == null) return;
    await _firestore
        .collection('coffees')
        .doc(_userId)
        .collection('favorites')
        .doc(coffee.id)
        .set({...coffee.toJson(), 'isFavorite': false});
    final updated = state.where((item) => item.id != coffee.id).toList();
    emit(_applySort(updated));
  }

  bool isFavorite(CoffeeItem coffee) {
    return state.any((item) => item.id == coffee.id);
  }

  void toggleSortOrder() {
    _sortOrder = _sortOrder == FavoriteSortOrder.ascending
        ? FavoriteSortOrder.descending
        : FavoriteSortOrder.ascending;
    emit(_applySort(state));
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    emit(List<CoffeeItem>.from(state)); // Triggers UI update
  }

  List<CoffeeItem> _applySort(List<CoffeeItem> list) {
    final sorted = List<CoffeeItem>.from(list);
    sorted.sort((a, b) => _sortOrder == FavoriteSortOrder.ascending
        ? a.price.compareTo(b.price)
        : b.price.compareTo(a.price));
    return sorted;
  }
}
