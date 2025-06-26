import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/coffee_card.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/special_offer_card.dart';
import '../widgets/custom_bottom_navigation.dart';
import '../widgets/category_tab.dart';
import '../theme/app_theme.dart';
import '../utils/app_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedBottomNavIndex = 0;
  int selectedCategoryIndex = 0;
  late PageController _pageController;

  final List<String> categories = [
    'Espresso',
    'Latte',
    'Cappuccino',
    'Cafetière',
  ];

  final Map<String, List<CoffeeItem>> coffeeItemsByCategory = {
    'Espresso': [
      CoffeeItem(
        name: 'Espresso',
        description: 'with Oat Milk',
        price: 4.20,
        rating: 4.5,
        image: 'assets/images/espresso_beans.png',
      ),
      CoffeeItem(
        name: 'Espresso',
        description: 'with Milk',
        price: 4.20,
        rating: 4.5,
        image: 'assets/images/espresso_cup.png',
      ),
    ],
    'Latte': [
      CoffeeItem(
        name: 'Caffe Latte',
        description: 'with Steamed Milk',
        price: 5.50,
        rating: 4.7,
        image: 'assets/images/latte_1.png',
      ),
      CoffeeItem(
        name: 'Iced Latte',
        description: 'with Cold Milk',
        price: 5.20,
        rating: 4.3,
        image: 'assets/images/latte_2.png',
      ),
    ],
    'Cappuccino': [
      CoffeeItem(
        name: 'Cappuccino',
        description: 'with Foam Art',
        price: 4.80,
        rating: 4.6,
        image: 'assets/images/cappuccino_1.png',
      ),
      CoffeeItem(
        name: 'Dry Cappuccino',
        description: 'Extra Foam',
        price: 4.90,
        rating: 4.4,
        image: 'assets/images/cappuccino_2.png',
      ),
    ],
    'Cafetière': [
      CoffeeItem(
        name: 'French Press',
        description: 'Bold & Rich',
        price: 3.80,
        rating: 4.2,
        image: 'assets/images/cafetiere_1.png',
      ),
      CoffeeItem(
        name: 'Cold Brew',
        description: 'Smooth & Strong',
        price: 4.00,
        rating: 4.5,
        image: 'assets/images/cafetiere_2.png',
      ),
    ],
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
              });
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCoffeePageView() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          selectedCategoryIndex = index;
        });
      },
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final items = coffeeItemsByCategory[category] ?? [];

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Column(
              children: [
                _buildCoffeeGrid(items),
                const SizedBox(height: 25),
                _buildSpecialOffer(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCoffeeGrid(List<CoffeeItem> items) {
    return Row(
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
                // TODO: Add navigation to product details screen in future
                print('Coffee card tapped: ${item.name}');
              },
              onAddTap: () {
                // Add to cart functionality
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
            onChanged: (value) {
              // Handle search text change
              print('Search: $value');
            },
          ),
        ),
        const SizedBox(width: 11),
        GestureDetector(
          onTap: () {
            // Handle filter tap
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

class CoffeeItem {
  final String name;
  final String description;
  final double price;
  final double rating;
  final String image;

  CoffeeItem({
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.image,
  });
}
