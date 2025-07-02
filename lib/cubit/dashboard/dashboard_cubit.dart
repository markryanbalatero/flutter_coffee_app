import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../core/models/coffee_item.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial()) {
    _initializeData();
  }
  final List<String> _categories = [
    'Espresso',
    'Latte',
    'Cappuccino',
    'Cafetière',
  ];

  final Map<String, List<CoffeeItem>> _coffeeItemsByCategory = {
    'Espresso': [
      CoffeeItem(
        id: 'espresso_1',
        name: 'Espresso',
        description: 'with Oat Milk',
        price: 4.20,
        rating: 4.5,
        image: 'assets/images/espresso_beans.png',
        sizes: ['S', 'M', 'L'],
        sizePrices: {'S': 4.20, 'M': 5.20, 'L': 6.20},
        isFavorite: false,
      ),
      CoffeeItem(
        id: 'espresso_2',
        name: 'Espresso',
        description: 'with Milk',
        price: 4.20,
        rating: 4.5,
        image: 'assets/images/espresso_cup.png',
        sizes: ['S', 'M', 'L'],
        sizePrices: {'S': 4.20, 'M': 5.20, 'L': 6.20},
        isFavorite: false,
      ),
    ],
    'Latte': [
      CoffeeItem(
        id: 'latte_1',
        name: 'Caffe Latte',
        description: 'with Steamed Milk',
        price: 5.50,
        rating: 4.7,
        image: 'assets/images/latte_1.png',
        sizes: ['S', 'M', 'L'],
        sizePrices: {'S': 5.50, 'M': 6.50, 'L': 7.50},
        isFavorite: false,
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
        isFavorite: false,
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
        isFavorite: false,
      ),
      CoffeeItem(
        id: 'cappuccino_2',
        name: 'Dry Cappuccino',
        description: 'Extra Foam',
        price: 4.90,
        rating: 4.4,
        image: 'assets/images/cappuccino_2.png',
        sizes: ['S', 'M', 'L'],
        sizePrices: {'S': 4.90, 'M': 5.90, 'L': 6.90},
        isFavorite: false,
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
        isFavorite: false,
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
        isFavorite: false,
      ),
    ],
  };
  void _initializeData() {
    emit(
      DashboardLoaded(
        selectedBottomNavIndex: 0,
        selectedCategoryIndex: 0,
        searchQuery: '',
        filteredItems: [],
        isSearchActive: false,
        categories: _categories,
        coffeeItemsByCategory: _coffeeItemsByCategory,
      ),
    );
  }
  void selectCategory(int index) {
    final currentState = state;
    if (currentState is DashboardLoaded) {
      emit(
        currentState.copyWith(
          selectedCategoryIndex: index,
          searchQuery: '',
          isSearchActive: false,
          filteredItems: [],
        ),
      );
    }
  }
  void handleSearch(String query) {
    final currentState = state;
    if (currentState is DashboardLoaded) {
      final searchQuery = query.toLowerCase();
      final isSearchActive = query.isNotEmpty;
      List<CoffeeItem> filteredItems = [];

      if (isSearchActive) {
        _coffeeItemsByCategory.forEach((category, items) {
          for (var item in items) {
            if (item.name.toLowerCase().contains(searchQuery) ||
                item.description.toLowerCase().contains(searchQuery) ||
                category.toLowerCase().contains(searchQuery)) {
              filteredItems.add(item);
            }
          }
        });
        int newCategoryIndex = currentState.selectedCategoryIndex;
        for (int i = 0; i < _categories.length; i++) {
          if (_categories[i].toLowerCase().contains(searchQuery)) {
            newCategoryIndex = i;
            break;
          }
        }

        emit(
          currentState.copyWith(
            selectedCategoryIndex: newCategoryIndex,
            searchQuery: searchQuery,
            isSearchActive: isSearchActive,
            filteredItems: filteredItems,
          ),
        );
      } else {
        emit(
          currentState.copyWith(
            searchQuery: searchQuery,
            isSearchActive: isSearchActive,
            filteredItems: filteredItems,
          ),
        );
      }
    }
  }
  void selectBottomNavItem(int index) {
    final currentState = state;
    if (currentState is DashboardLoaded) {
      emit(currentState.copyWith(selectedBottomNavIndex: index));
    }
  }

  void addToCart(CoffeeItem item) {
    print('Adding ${item.name} to cart');
  }

  void navigateToProduct(CoffeeItem item) {
    print('Navigating to product: ${item.name}');
  }
}
