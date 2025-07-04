import '../../core/models/coffee_item.dart';

/// State class for the Dashboard screen
class DashboardState {
  final Map<String, List<CoffeeItem>> coffeeItemsByCategory;
  final List<String> categories;
  final int selectedCategoryIndex;
  final String searchQuery;
  final List<CoffeeItem> filteredItems;
  final bool isSearchActive;
  final bool isLoading;
  final String? errorMessage;

  const DashboardState({
    required this.coffeeItemsByCategory,
    required this.categories,
    this.selectedCategoryIndex = 0,
    this.searchQuery = '',
    this.filteredItems = const [],
    this.isSearchActive = false,
    this.isLoading = false,
    this.errorMessage,
  });

  /// Creates a copy of the current state with updated values
  DashboardState copyWith({
    Map<String, List<CoffeeItem>>? coffeeItemsByCategory,
    List<String>? categories,
    int? selectedCategoryIndex,
    String? searchQuery,
    List<CoffeeItem>? filteredItems,
    bool? isSearchActive,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DashboardState(
      coffeeItemsByCategory: coffeeItemsByCategory ?? this.coffeeItemsByCategory,
      categories: categories ?? this.categories,
      selectedCategoryIndex: selectedCategoryIndex ?? this.selectedCategoryIndex,
      searchQuery: searchQuery ?? this.searchQuery,
      filteredItems: filteredItems ?? this.filteredItems,
      isSearchActive: isSearchActive ?? this.isSearchActive,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// Gets coffee items for the currently selected category
  List<CoffeeItem> get currentCategoryItems {
    if (selectedCategoryIndex >= 0 && selectedCategoryIndex < categories.length) {
      final categoryName = categories[selectedCategoryIndex];
      return coffeeItemsByCategory[categoryName] ?? [];
    }
    return [];
  }

  /// Gets the currently selected category name
  String get currentCategoryName {
    if (selectedCategoryIndex >= 0 && selectedCategoryIndex < categories.length) {
      return categories[selectedCategoryIndex];
    }
    return '';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DashboardState &&
        other.coffeeItemsByCategory == coffeeItemsByCategory &&
        other.categories == categories &&
        other.selectedCategoryIndex == selectedCategoryIndex &&
        other.searchQuery == searchQuery &&
        other.filteredItems == filteredItems &&
        other.isSearchActive == isSearchActive &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return coffeeItemsByCategory.hashCode ^
        categories.hashCode ^
        selectedCategoryIndex.hashCode ^
        searchQuery.hashCode ^
        filteredItems.hashCode ^
        isSearchActive.hashCode ^
        isLoading.hashCode ^
        errorMessage.hashCode;
  }

  @override
  String toString() {
    return 'DashboardState(coffeeItemsByCategory: $coffeeItemsByCategory, categories: $categories, selectedCategoryIndex: $selectedCategoryIndex, searchQuery: $searchQuery, filteredItems: $filteredItems, isSearchActive: $isSearchActive, isLoading: $isLoading, errorMessage: $errorMessage)';
  }
}
