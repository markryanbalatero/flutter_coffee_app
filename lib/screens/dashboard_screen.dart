import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/screens/espresso_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/models/coffee_item.dart';
import '../widgets/coffee_card.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/special_offer_card.dart';
import '../widgets/custom_bottom_navigation.dart';
import '../widgets/category_tab.dart';
import '../theme/app_theme.dart';
import '../utils/app_colors.dart';
import '../widgets/search_results_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedBottomNavIndex = 0;
  int selectedCategoryIndex = 0;
  String searchQuery = '';
  List<CoffeeItem> filteredItems = [];
  bool isSearchActive = false;

  final List<String> categories = [
    'Espresso',
    'Latte',
    'Cappuccino',
    'Cafetière',
  ];

  final Map<String, List<CoffeeItem>> coffeeItemsByCategory = {
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
  };

  void _handleSearch(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      isSearchActive = query.isNotEmpty;

      if (isSearchActive) {
        // Search across all categories
        filteredItems = [];
        coffeeItemsByCategory.forEach((category, items) {
          for (var item in items) {
            if (item.name.toLowerCase().contains(searchQuery) ||
                item.description.toLowerCase().contains(searchQuery) ||
                category.toLowerCase().contains(searchQuery)) {
              filteredItems.add(item);
            }
          }
        });
        for (int i = 0; i < categories.length; i++) {
          if (categories[i].toLowerCase().contains(searchQuery)) {
            selectedCategoryIndex = i;
            break;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 65),
                  _buildHeader(),
                  const SizedBox(height: 35),
                  _buildGreeting(),
                  const SizedBox(height: 35),
                  _buildSearchBar(),
                  const SizedBox(height: 25),
                ],
              ),
            ),
            _buildCategoryTabs(),
            Expanded(child: _buildCoffeePageView()),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 45,
      margin: const EdgeInsets.only(left: 23, bottom: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryTab(
            title: categories[index],
            isSelected: selectedCategoryIndex == index,
            onTap: () {
              setState(() {
                selectedCategoryIndex = index;
                searchQuery = '';
                isSearchActive = false;
                filteredItems = [];
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildCoffeePageView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          children: [
            if (isSearchActive)
              SearchResultsView(
                searchQuery: searchQuery,
                filteredItems: filteredItems,
                onCoffeeCardTap: (item) {
                  // TODO: Add navigation to product details screen in future
                  print('Coffee card tapped: ${item.name}');
                },
                onAddToCart: (item) {
                  // Add to cart functionality
                  print('Add to cart: ${item.name}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item.name} added to cart'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              )
            else
              _buildCategoryView(),
            const SizedBox(height: 25),
            if (!isSearchActive) _buildSpecialOffer(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryView() {
    final items =
        coffeeItemsByCategory[categories[selectedCategoryIndex]] ?? [];

    return Column(
      children: [
        Row(
          children: items.map((item) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 9),
                child: CoffeeCard(
                  name: item.name,
                  description: item.description,
                  price: item.price,
                  rating: item.rating,
                  imageAsset: item.image,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EspressoScreen(product: item)));
                  },
                  onAddTap: () {
                    // TODO: Add to cart functionality here
                    print('Add to cart: ${item.name}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item.name} added to cart'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/menu_button.svg',
              width: 32,
              height: 32,
              colorFilter: const ColorFilter.mode(
                AppColors.menuIconColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23),
            image: const DecorationImage(
              image: AssetImage('assets/images/profile.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    return SizedBox(
      width: 223,
      child: Text(
        'Find the best Coffee to your taste',
        style: AppTheme.greetingStyle,
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: CustomSearchBar(
            hintText: 'Find your coffee...',
            onChanged: _handleSearch,
          ),
        ),
        const SizedBox(width: 11),
        GestureDetector(
          onTap: () {
            print('Filter tapped');
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: AppColors.filterButtonColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: SvgPicture.asset(
                'assets/icons/filter.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.filterIconColor,
                  BlendMode.srcIn,
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialOffer() {
    return SpecialOfferCard(
      title: 'Special for you',
      description: 'Specially mixed and brewed which you must try!',
      currentPrice: 11.00,
      originalPrice: 20.3,
      imageAsset: 'assets/images/coffee_splash.png',
      onTap: () {
        print('Special offer tapped');
      },
    );
  }

  Widget _buildBottomNavigation() {
    return CustomBottomNavigation(
      selectedIndex: selectedBottomNavIndex,
      onItemTapped: (index) {
        setState(() {
          selectedBottomNavIndex = index;
        });
      },
    );
  }
}
