import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_app/screens/espresso_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../cubit/dashboard/dashboard_cubit.dart';
import '../cubit/dashboard/dashboard_state.dart';
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

  @override
  void initState() {
    super.initState();
    // Initialize the dashboard cubit
    context.read<DashboardCubit>().initializeDashboard();
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
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Container(
          height: 45,
          margin: const EdgeInsets.only(left: 23, bottom: 20),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              return CategoryTab(
                title: state.categories[index],
                isSelected: state.selectedCategoryIndex == index,
                onTap: () {
                  context.read<DashboardCubit>().selectCategory(index);
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCoffeePageView() {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Column(
              children: [
                if (state.isSearchActive)
                  SearchResultsView(
                    searchQuery: state.searchQuery,
                    filteredItems: state.filteredItems,
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
                  _buildCategoryView(state),
                const SizedBox(height: 25),
                if (!state.isSearchActive) _buildSpecialOffer(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryView(DashboardState state) {
    final items =
        state.coffeeItemsByCategory[state.categories[state
            .selectedCategoryIndex]] ??
        [];

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
                        builder: (context) => EspressoScreen(product: item),
                      ),
                    );
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
            onChanged: (query) {
              context.read<DashboardCubit>().handleSearch(query);
            },
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
