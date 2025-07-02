part of 'dashboard_cubit.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardLoaded extends DashboardState {
  final int selectedBottomNavIndex;
  final int selectedCategoryIndex;
  final String searchQuery;
  final List<CoffeeItem> filteredItems;
  final bool isSearchActive;
  final List<String> categories;
  final Map<String, List<CoffeeItem>> coffeeItemsByCategory;

  DashboardLoaded({
    required this.selectedBottomNavIndex,
    required this.selectedCategoryIndex,
    required this.searchQuery,
    required this.filteredItems,
    required this.isSearchActive,
    required this.categories,
    required this.coffeeItemsByCategory,
  });

  DashboardLoaded copyWith({
    int? selectedBottomNavIndex,
    int? selectedCategoryIndex,
    String? searchQuery,
    List<CoffeeItem>? filteredItems,
    bool? isSearchActive,
    List<String>? categories,
    Map<String, List<CoffeeItem>>? coffeeItemsByCategory,
  }) {
    return DashboardLoaded(
      selectedBottomNavIndex:
          selectedBottomNavIndex ?? this.selectedBottomNavIndex,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      searchQuery: searchQuery ?? this.searchQuery,
      filteredItems: filteredItems ?? this.filteredItems,
      isSearchActive: isSearchActive ?? this.isSearchActive,
      categories: categories ?? this.categories,
      coffeeItemsByCategory:
          coffeeItemsByCategory ?? this.coffeeItemsByCategory,
    );
  }
}

final class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}
