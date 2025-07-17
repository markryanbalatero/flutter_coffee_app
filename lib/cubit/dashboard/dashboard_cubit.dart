import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import '../../core/models/coffee_item.dart';
import '../../services/firestore_service.dart';
import 'dashboard_state.dart';

/// Cubit for managing the Dashboard screen state and business logic
class DashboardCubit extends Cubit<DashboardState> {
  StreamSubscription<List<CoffeeItem>>? _coffeeStreamSubscription;

  DashboardCubit() : super(_initialState);

  /// Initial state with coffee data
  static final DashboardState _initialState = DashboardState(
    categories: const ['Espresso', 'Latte', 'Cappuccino', 'Cafetière'],
    coffeeItemsByCategory: {
      'Espresso': [
        CoffeeItem(
          id: 'espresso_1',
          name: '1 Espresso',
          description: '1 with Oat Milk',
          price: 4.20,
          rating: 4.5,
          image: 'assets/images/espresso_beans.png',
          sizes: ['S', 'M', 'L'],
          sizePrices: {'S': 4.20, 'M': 5.20, 'L': 6.20},
          category: 'espresso',
        ),
        CoffeeItem(
          id: 'espresso_2',
          name: '2 Espresso',
          description: '2 with Milk',
          price: 4.20,
          rating: 4.5,
          image: 'assets/images/espresso_cup.png',
          sizes: ['S', 'M', 'L'],
          sizePrices: {'S': 4.20, 'M': 5.20, 'L': 6.20},
          category: 'espresso',
        ),
      ],
      'Latte': [
        CoffeeItem(
          id: 'latte_1',
          name: '3 Caffe Latte',
          description: '3 with Steamed Milk',
          price: 5.50,
          rating: 4.7,
          image: 'assets/images/latte_1.png',
          sizes: ['S', 'M', 'L'],
          sizePrices: {'S': 5.50, 'M': 6.50, 'L': 7.50},
          category: 'latte',
        ),
        CoffeeItem(
          id: 'latte_2',
          name: 'Iced Latte',
          description: 'with Cold Milk',
          price: 5.20,
          rating: 4.3,
          image: 'assets/images/latte_2.png',
          sizes: ['S', 'M', 'L'],
          sizePrices: {'S': 5.20, 'M': 6.20, 'L': 7.20},
          category: 'latte',
        ),
      ],
      'Cappuccino': [
        CoffeeItem(
          id: 'cappuccino_1',
          name: 'Cappuccino',
          description: 'with Foam Art',
          price: 4.80,
          rating: 4.6,
          image: 'assets/images/cappuccino_1.png',
          sizes: ['S', 'M', 'L'],
          sizePrices: {'S': 4.80, 'M': 5.80, 'L': 6.80},
          category: 'cappuccino',
        ),
        CoffeeItem(
          id: 'cappuccino_2',
          name: 'Cappuccino',
          description: 'Extra Foam',
          price: 4.90,
          rating: 4.4,
          image: 'assets/images/cappuccino_2.png',
          sizes: ['S', 'M', 'L'],
          sizePrices: {'S': 4.90, 'M': 5.90, 'L': 6.90},
          category: 'cappuccino',
        ),
      ],
      'Cafetière': [
        CoffeeItem(
          id: 'cafetiere_1',
          name: 'French Press',
          description: 'Bold & Rich',
          price: 3.80,
          rating: 4.2,
          image: 'assets/images/cafetiere_1.png',
          sizes: ['S', 'M', 'L'],
          sizePrices: {'S': 3.80, 'M': 4.80, 'L': 5.80},
          category: 'cafetière',
        ),
        CoffeeItem(
          id: 'cafetiere_2',
          name: 'Cold Brew',
          description: 'Smooth & Strong',
          price: 4.00,
          rating: 4.5,
          image: 'assets/images/cafetiere_2.png',
          sizes: ['S', 'M', 'L'],
          sizePrices: {'S': 4.00, 'M': 5.00, 'L': 6.00},
          category: 'cafetière',
        ),
      ],
    },
  );

  /// Initializes the dashboard with coffee data
  void initializeDashboard() {
    if (isClosed) return;
    emit(state.copyWith(isLoading: true));
    _loadCoffeeItemsFromFirestore();
  }

  /// Load coffee items from Firestore and merge with existing data
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

  /// Merge Firestore coffee items with existing hardcoded items
  void _mergeCoffeeItems(List<CoffeeItem> firestoreCoffees) {
    if (isClosed) return;

    final Map<String, List<CoffeeItem>> mergedCategories =
        Map.from(state.coffeeItemsByCategory);

    for (final coffee in firestoreCoffees) {
      final categoryKey = _getCategoryKey(coffee.category);
      if (categoryKey != null) {
        mergedCategories[categoryKey] ??= [];

        final existingIndex = mergedCategories[categoryKey]!
            .indexWhere((existingCoffee) => existingCoffee.id == coffee.id);

        if (existingIndex >= 0) {
          mergedCategories[categoryKey]![existingIndex] = coffee;
        } else {
          mergedCategories[categoryKey]!.add(coffee);
        }
      }
    }

    emit(state.copyWith(
      coffeeItemsByCategory: mergedCategories,
      isLoading: false,
      errorMessage: null,
    ));
  }

  /// Get the proper category key for the coffee category
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

  /// Refresh coffee items from Firestore
  void refreshCoffeeItems() {
    if (isClosed) return;
    emit(state.copyWith(isLoading: true));
    _loadCoffeeItemsFromFirestore();
  }

  @override
  Future<void> close() {
    _coffeeStreamSubscription?.cancel();
    return super.close();
  }

  /// Selects a category by index
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

  /// Handles search functionality
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

  /// Performs the actual search across all categories
  void _performSearch(String query) {
    final List<CoffeeItem> filteredItems = [];
    int? categoryIndex;

    // Search across all categories
    state.coffeeItemsByCategory.forEach((category, items) {
      for (var item in items) {
        if (item.name.toLowerCase().contains(query) ||
            item.description.toLowerCase().contains(query) ||
            category.toLowerCase().contains(query)) {
          filteredItems.add(item);
        }
      }

      // If category name matches, set it as selected
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
