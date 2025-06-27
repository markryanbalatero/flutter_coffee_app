import 'package:flutter/material.dart';
import '../widgets/coffee_card.dart';
import '../theme/app_theme.dart';
import '../utils/app_colors.dart';
import '../screens/dashboard_screen.dart';

class SearchResultsView extends StatelessWidget {
  final String searchQuery;
  final List<CoffeeItem> filteredItems;
  final Function(CoffeeItem) onCoffeeCardTap;
  final Function(CoffeeItem) onAddToCart;

  const SearchResultsView({
    super.key,
    required this.searchQuery,
    required this.filteredItems,
    required this.onCoffeeCardTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSearchHeader(),
        const SizedBox(height: 20),
        _buildSearchResults(),
      ],
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.searchBackground.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.searchBorder.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Search results for "$searchQuery"',
              style: AppTheme.dashboardSearchHeaderStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.coffeeAccent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${filteredItems.length}',
              style: AppTheme.dashboardSearchCountStyle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (filteredItems.isEmpty) {
      return _buildNoResultsWidget();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double cardWidth = 160; 
        double spacing = (screenWidth - (cardWidth * 2)) / 3;
        spacing = spacing.clamp(8.0, 20.0);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: spacing,
            mainAxisSpacing: 16,
            childAspectRatio:
                cardWidth / 240,
          ),
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            final item = filteredItems[index];
            return _buildSearchResultCard(item, cardWidth);
          },
        );
      },
    );
  }

  Widget _buildSearchResultCard(CoffeeItem item, double cardWidth) {
    return Container(
      width: cardWidth,
      constraints: const BoxConstraints(maxHeight: 240, minHeight: 220),
      child: CoffeeCard(
        name: item.name,
        description: item.description,
        price: item.price,
        rating: item.rating,
        imageAsset: item.image,
        onTap: () => onCoffeeCardTap(item),
        onAddTap: () => onAddToCart(item),
      ),
    );
  }

  Widget _buildNoResultsWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.coffeeTextSecondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 40,
              color: AppColors.coffeeTextSecondary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No coffee found',
            style: AppTheme.dashboardNoResultsTitleStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching with different keywords\nor browse our categories',
            style: AppTheme.dashboardNoResultsDescriptionStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.coffeeAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.coffeeAccent.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Text(
              'Searched for: "$searchQuery"',
              style: AppTheme.dashboardSearchCountStyle.copyWith(
                color: AppColors.coffeeAccent,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
