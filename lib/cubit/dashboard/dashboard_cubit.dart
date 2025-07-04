import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/models/coffee_item.dart';
import 'dashboard_state.dart';

/// Cubit for managing the Dashboard screen state and business logic
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(_initialState);

  /// Initial state with coffee data
  static final DashboardState _initialState = DashboardState(
    categories: const [
      'Espresso',
      'Latte',
      'Cappuccino',
      'Cafetière',
    ],
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
        ),
      ],
    },
  );

  /// Initializes the dashboard with coffee data
  void initializeDashboard() {
    emit(state.copyWith(isLoading: false));
  }

  /// Selects a category by index
  void selectCategory(int categoryIndex) {
    if (categoryIndex >= 0 && categoryIndex < state.categories.length) {
      emit(state.copyWith(
        selectedCategoryIndex: categoryIndex,
        searchQuery: '',
        isSearchActive: false,
        filteredItems: [],
      ));
    }
  }

  /// Handles search functionality
  void handleSearch(String query) {
    final lowerQuery = query.toLowerCase();
    emit(state.copyWith(
      searchQuery: lowerQuery,
      isSearchActive: query.isNotEmpty,
    ));

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

    emit(state.copyWith(
      filteredItems: filteredItems,
      selectedCategoryIndex: categoryIndex ?? state.selectedCategoryIndex,
    ));
  }

  /// Clears search and returns to normal view
  void clearSearch() {
    emit(state.copyWith(
      searchQuery: '',
      isSearchActive: false,
      filteredItems: [],
    ));
  }

  /// Sets loading state
  void setLoading(bool isLoading) {
    emit(state.copyWith(isLoading: isLoading));
  }

  /// Sets error message
  void setError(String? errorMessage) {
    emit(state.copyWith(errorMessage: errorMessage));
  }

  /// Gets coffee items for a specific category
  List<CoffeeItem> getCoffeeItemsForCategory(String categoryName) {
    return state.coffeeItemsByCategory[categoryName] ?? [];
  }

  /// Gets all coffee items across all categories
  List<CoffeeItem> getAllCoffeeItems() {
    final allItems = <CoffeeItem>[];
    state.coffeeItemsByCategory.values.forEach((items) {
      allItems.addAll(items);
    });
    return allItems;
  }

  /// Gets popular coffee items (high rating)
  List<CoffeeItem> getPopularCoffeeItems() {
    final allItems = getAllCoffeeItems();
    allItems.sort((a, b) => b.rating.compareTo(a.rating));
    return allItems.take(5).toList(); // Top 5 rated items
  }

  /// Gets coffee items in a specific price range
  List<CoffeeItem> getCoffeeItemsByPriceRange(double minPrice, double maxPrice) {
    final allItems = getAllCoffeeItems();
    return allItems.where((item) => item.price >= minPrice && item.price <= maxPrice).toList();
  }

  /// Toggles favorite status for a coffee item
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
