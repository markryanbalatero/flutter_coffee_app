import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_app/screens/espresso_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import '../cubit/theme/theme_cubit.dart';
import 'dart:io';

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
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == ThemeMode.dark;
        final theme = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 65),
                      _buildHeader(theme),
                      const SizedBox(height: 35),
                      _buildGreeting(theme),
                      const SizedBox(height: 35),
                      _buildSearchBar(theme),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
                _buildCategoryTabs(theme),
                Expanded(child: _buildCoffeePageView(theme)),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomNavigation(),
        );
      },
    );
  }

  Widget _buildCategoryTabs(ThemeData theme) {
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

  Widget _buildCoffeePageView(ThemeData theme) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
            ),
          );
        }

        if (state.errorMessage != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                ),
                const SizedBox(height: 16),
                Text(
                  'Error Loading Coffee Items',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.errorMessage!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    context.read<DashboardCubit>().refreshCoffeeItems();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

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
                      print('Coffee card tapped: ${item.name}');
                    },
                    onAddToCart: (item) {
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
                  _buildCategoryView(state, theme),
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

  Widget _buildCategoryView(DashboardState state, ThemeData theme) {
    final items = state.coffeeItemsByCategory[
            state.categories[state.selectedCategoryIndex]] ??
        [];

    if (items.isEmpty) {
      return Container(
        height: 250,
        child: Center(
          child: Text(
            'No coffee items available',
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 18,
            mainAxisSpacing: 20,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return CoffeeCard(
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
                print('Add to cart: ${item.name}');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${item.name} added to cart'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildHeader(ThemeData theme) {
    final user = FirebaseAuth.instance.currentUser;
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
              colorFilter: ColorFilter.mode(
                theme.iconTheme.color ?? AppColors.menuIconColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/profile');
          },
          child: FutureBuilder<DocumentSnapshot>(
            future: user != null
                ? FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .get()
                : Future.value(null),
            builder: (context, snapshot) {
              String? imagePath;
              if (snapshot.hasData && snapshot.data != null) {
                final data = snapshot.data!.data() as Map<String, dynamic>?;
                imagePath = data?['imagePath'];
              }
              ImageProvider imageProvider;
              if (imagePath != null && imagePath.isNotEmpty) {
                imageProvider = FileImage(File(imagePath));
              } else {
                imageProvider = const AssetImage('assets/images/profile.png');
              }
              return Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGreeting(ThemeData theme) {
    return SizedBox(
      width: 223,
      child: Text(
        'Find the best Coffee to your taste',
        style: theme.textTheme.bodyLarge?.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
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
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: const BorderRadius.only(
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
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.onPrimary,
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
      imageAsset: 'assets/images/coffee_espresso.png',
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
        if (index == 4) {
          Navigator.pushNamed(context, '/profile');
        }
      },
      onAddTapped: () {
        Navigator.pushNamed(context, '/add-coffee');
      },
    );
  }
}
