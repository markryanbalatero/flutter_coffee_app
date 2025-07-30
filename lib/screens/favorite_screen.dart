import 'package:flutter/material.dart';
import 'package:flutter_coffee_app/core/theme/app_colors.dart';
import 'package:flutter_coffee_app/cubit/dashboard/dashboard_cubit.dart';
import 'package:flutter_coffee_app/widgets/custom_bottom_navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_app/widgets/custom_search_bar.dart';
import 'package:flutter_svg/svg.dart';
import '../cubit/favorite_cubit.dart';
import '../core/models/coffee_item.dart';
import '../widgets/cards/favorite_coffee_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text('Favorites',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildSearchBar(context),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<FavoriteCubit, List<CoffeeItem>>(
                builder: (context, favorites) {
                  // Filter favorites based on search query only
                  List<CoffeeItem> filteredFavorites = _searchQuery.isEmpty
                      ? favorites
                      : favorites
                          .where((coffee) => coffee.name
                              .toLowerCase()
                              .contains(_searchQuery.toLowerCase()))
                          .toList();

                  if (filteredFavorites.isEmpty) {
                    return Center(child: Text('No favorites found'));
                  }
                  return ListView.separated(
                    itemCount: filteredFavorites.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final coffee = filteredFavorites[index];
                      return FavoriteCoffeeCard(
                        coffee: coffee,
                        onRemoveFromFavorites: () => context
                            .read<FavoriteCubit>()
                            .removeFavorite(coffee),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/espresso',
                            arguments: coffee,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: 1,
        onItemTapped: (index) {
          if (index == 1) {
            // Already on Favorites, do nothing or show a message
          } else if (index == 4) {
            Navigator.pushNamed(context, '/profile');
          } else {
            Navigator.pushNamed(context, '/dashboard');
          }
        },
        onAddTapped: () {
          Navigator.pushNamed(context, '/add-coffee');
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final sortOrder = context.watch<FavoriteCubit>().sortOrder;
    return Row(
      children: [
        Expanded(
          child: CustomSearchBar(
            hintText: 'Find your coffee...',
            onChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
            },
          ),
        ),
        const SizedBox(width: 11),
        GestureDetector(
          onTap: () {
            context.read<FavoriteCubit>().toggleSortOrder();
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xFF967259),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(13),
                  child: SvgPicture.asset(
                    'assets/icons/filter.svg',
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFFFFFFF),
                      BlendMode.srcIn,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  bottom: 6,
                  right: 6,
                  child: Icon(
                    sortOrder == FavoriteSortOrder.ascending
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    size: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
