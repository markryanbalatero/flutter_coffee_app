import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import '../../core/models/coffee_item.dart';
import '../../services/firestore_service.dart';
import 'dashboard_state.dart';


class DashboardCubit extends Cubit<DashboardState> {
  StreamSubscription<List<CoffeeItem>>? _coffeeStreamSubscription;
  StreamSubscription? _userFavoritesSubscription;
  StreamSubscription? _specificUserFavoritesSubscription;

  DashboardCubit() : super(_initialState);

  
  static final DashboardState _initialState = DashboardState(
    categories: const ['Espresso', 'Latte', 'Cappuccino', 'Cafetière'],
    coffeeItemsByCategory: {
      'Espresso': [],
      'Latte': [],
      'Cappuccino': [],
      'Cafetière': [],
    },
  );
  void initializeDashboard() {
    if (isClosed) return;
    emit(state.copyWith(isLoading: true));
    _loadCoffeeItemsFromFirestore();
  }

  void _loadCoffeeItemsFromFirestore() {
    _coffeeStreamSubscription?.cancel();
    _coffeeStreamSubscription = FirestoreService.getCoffeesStream().listen(
      (firestoreCoffees) {
        if (!isClosed) {
          _mergeCoffeeItems(firestoreCoffees);
        }
      },
      onError: (error) {
        if (!isClosed) {
          emit(state.copyWith(
            isLoading: false,
            errorMessage: 'Failed to load coffee items: $error',
          ));
        }
      },
    );
  }

  
  void _mergeCoffeeItems(List<CoffeeItem> firestoreCoffees) {
    if (isClosed) return;

    final Map<String, List<CoffeeItem>> categorizedCoffees = {
      'Espresso': [],
      'Latte': [],
      'Cappuccino': [],
      'Cafetière': [],
    };

    for (final coffee in firestoreCoffees) {
      final categoryKey = _getCategoryKey(coffee.category);
      if (categoryKey != null) {
        categorizedCoffees[categoryKey]!.add(coffee);
      }
    }

    emit(state.copyWith(
      coffeeItemsByCategory: categorizedCoffees,
      isLoading: false,
      errorMessage: null,
    ));
  }

  
  String? _getCategoryKey(String category) {
    final categoryLower = category.toLowerCase();
    switch (categoryLower) {
      case 'espresso':
        return 'Espresso';
      case 'latte':
        return 'Latte';
      case 'cappuccino':
        return 'Cappuccino';
      case 'cafetière':
      case 'cafetiere':
        return 'Cafetière';
      default:
        return null;
    }
  }

  
  void refreshCoffeeItems() {
    if (isClosed) return;
    emit(state.copyWith(isLoading: true));
    _loadCoffeeItemsFromFirestore();
  }

  void initializeUserFavorites(String userId) {
    _userFavoritesSubscription = FirestoreService.getUserFavoriteCoffees(userId).listen(
      (userFavorites) {
       
        final Map<String, List<CoffeeItem>> categorizedFavorites = {
          'Favorites': userFavorites
        };

       
        final updatedCategories = Map<String, List<CoffeeItem>>.from(state.coffeeItemsByCategory);
        updatedCategories['Favorites'] = userFavorites;

        emit(state.copyWith(
          coffeeItemsByCategory: updatedCategories,
          selectedCategoryIndex: state.categories.indexOf('Favorites') != -1 
            ? state.categories.indexOf('Favorites') 
            : state.selectedCategoryIndex
        ));
      },
      onError: (error) {
        print('Error fetching user favorites: $error');
      },
    );
  }

  void initializeSpecificUserFavorites() {
    _specificUserFavoritesSubscription = FirestoreService.getSpecificUserFavorites().listen(
      (specificUserFavorites) {
       
        final Map<String, List<CoffeeItem>> categorizedFavorites = {
          'Favorites': specificUserFavorites
        };

       
        final updatedCategories = Map<String, List<CoffeeItem>>.from(state.coffeeItemsByCategory);
        updatedCategories['Favorites'] = specificUserFavorites;

        emit(state.copyWith(
          coffeeItemsByCategory: updatedCategories,
          selectedCategoryIndex: state.categories.indexOf('Favorites') != -1 
            ? state.categories.indexOf('Favorites') 
            : state.selectedCategoryIndex
        ));
      },
      onError: (error) {
        print('Error fetching specific user favorites: $error');
      },
    );
  }

  @override
  Future<void> close() {
    _coffeeStreamSubscription?.cancel();
    _userFavoritesSubscription?.cancel();
    _specificUserFavoritesSubscription?.cancel();
    return super.close();
  }

  
  void selectCategory(int categoryIndex) {
    if (categoryIndex >= 0 && categoryIndex < state.categories.length) {
      emit(
        state.copyWith(
          selectedCategoryIndex: categoryIndex,
          searchQuery: '',
          isSearchActive: false,
          filteredItems: [],
        ),
      );
    }
  }

  
  void handleSearch(String query) {
    final lowerQuery = query.toLowerCase();
    emit(
      state.copyWith(searchQuery: lowerQuery, isSearchActive: query.isNotEmpty),
    );

    if (query.isNotEmpty) {
      _performSearch(lowerQuery);
    } else {
      emit(state.copyWith(filteredItems: []));
    }
  }

  
  void _performSearch(String query) {
    final List<CoffeeItem> filteredItems = [];
    int? categoryIndex;

    
    state.coffeeItemsByCategory.forEach((category, items) {
      for (var item in items) {
        if (item.name.toLowerCase().contains(query) ||
            item.description.toLowerCase().contains(query) ||
            category.toLowerCase().contains(query)) {
          filteredItems.add(item);
        }
      }

      if (category.toLowerCase().contains(query)) {
        categoryIndex = state.categories.indexOf(category);
      }
    });

    emit(
      state.copyWith(
        filteredItems: filteredItems,
        selectedCategoryIndex: categoryIndex ?? state.selectedCategoryIndex,
      ),
    );
  }

  void clearSearch() {
    emit(
      state.copyWith(searchQuery: '', isSearchActive: false, filteredItems: []),
    );
  }

  void selectBottomNavIndex(int index) {
    emit(state.copyWith(selectedBottomNavIndex: index));
  }

  void setLoading(bool isLoading) {
    emit(state.copyWith(isLoading: isLoading));
  }

  void setError(String? errorMessage) {
    emit(state.copyWith(errorMessage: errorMessage));
  }

  List<CoffeeItem> getCoffeeItemsForCategory(String categoryName) {
    return state.coffeeItemsByCategory[categoryName] ?? [];
  }

  List<CoffeeItem> getAllCoffeeItems() {
    final allItems = <CoffeeItem>[];
    state.coffeeItemsByCategory.values.forEach((items) {
      allItems.addAll(items);
    });
    return allItems;
  }

  List<CoffeeItem> getPopularCoffeeItems() {
    final allItems = getAllCoffeeItems();
    allItems.sort((a, b) => b.rating.compareTo(a.rating));
    return allItems.take(5).toList();
  }

  List<CoffeeItem> getCoffeeItemsByPriceRange(
    double minPrice,
    double maxPrice,
  ) {
    final allItems = getAllCoffeeItems();
    return allItems
        .where((item) => item.price >= minPrice && item.price <= maxPrice)
        .toList();
  }

  void toggleFavorite(String coffeeId) {
    final updatedCategories = <String, List<CoffeeItem>>{};

    state.coffeeItemsByCategory.forEach((category, items) {
      final updatedItems = items.map((item) {
        if (item.id == coffeeId) {
          return CoffeeItem(
            id: item.id,
            name: item.name,
            description: item.description,
            price: item.price,
            rating: item.rating,
            image: item.image,
            sizes: item.sizes,
            sizePrices: item.sizePrices,
            category: item.category,
            isFavorite: !item.isFavorite,
          );
        }
        return item;
      }).toList();
      updatedCategories[category] = updatedItems;
    });

    emit(state.copyWith(coffeeItemsByCategory: updatedCategories));
  }
}
