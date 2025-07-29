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
import '../theme/app_theme.dart';
import '../core/constants/app_constants.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

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
                  if (favorites.isEmpty) {
                    return Center(child: Text('No favorites yet'));
                  }
                  return ListView.separated(
                    itemCount: favorites.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final coffee = favorites[index];
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
              color: Color(0xFF967259),
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
                  Color(0xFFFFFFFF),
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
}
