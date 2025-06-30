import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../theme/app_theme.dart';

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  final double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint()..color = color;
    final Offset circleOffset =
        offset +
        Offset(
          configuration.size!.width / 2,
          configuration.size!.height - radius - 2,
        );

    canvas.drawCircle(circleOffset, radius, paint);
  }
}

class CoffeeTabBar extends StatelessWidget {
  final TabController tabController;
  final List<String> tabs;

  const CoffeeTabBar({
    super.key,
    required this.tabController,
    required this.tabs,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: TabBar(
              controller: tabController,
              isScrollable: false,
              labelColor: AppColors.categoryTabSelectedColor,
              unselectedLabelColor: AppColors.categoryTabUnselectedColor,
              labelStyle: AppTheme.coffeeTabBarSelectedStyle,
              unselectedLabelStyle: AppTheme.coffeeTabBarUnselectedStyle,
              indicator: CircleTabIndicator(
                color: AppColors.categoryTabSelectedColor,
                radius: 5,
              ),
              tabs: tabs
                  .map(
                    (String tab) => Tab(
                      height: 35,
                      child: SizedBox(
                        width:
                            MediaQuery.of(context).size.width / tabs.length - 8,
                        child: Text(
                          tab,
                          textAlign: TextAlign.center,
                          style: AppTheme.coffeeTabBarCustomTextStyle.copyWith(
                            height: 1.0,
                            letterSpacing: tab.length > 8 ? -0.6 : -0.2,
                          ),
                          overflow: TextOverflow.visible,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        Container(
          height: 290,
          padding: const EdgeInsets.only(top: 10),
          width: double.infinity,
          alignment: Alignment.center,
          child: TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildTabContent('Espresso', 'with Oat Milk', 'with Milk'),

              // Latte Tab Content
              _buildTabContent('Latte', 'with Fresh Milk', 'with Almond Milk'),

              // Cappuccino Tab Content
              _buildTabContent('Cappuccino', 'with Foam', 'with Chocolate'),

              // Cafetière Tab Content
              _buildTabContent('Cafetière', 'French Press', 'Strong Brew'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabContent(String title, String subtitle1, String subtitle2) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Center(
          child: SizedBox(
            width: 355,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 15,
              runSpacing: 15,
              children: [
                _buildCoffeeCard(
                  image: 'assets/images/espresso_beans.png',
                  title: title,
                  subtitle: subtitle1,
                  price: _getPriceForCoffee(title, subtitle1),
                ),
                _buildCoffeeCard(
                  image: 'assets/images/espresso_cup.png',
                  title: title,
                  subtitle: subtitle2,
                  price: _getPriceForCoffee(title, subtitle2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getPriceForCoffee(String title, String subtitle) {
    switch (title) {
      case 'Espresso':
        return '4.20';
      case 'Latte':
        return subtitle.contains('Almond') ? '4.80' : '4.50';
      case 'Cappuccino':
        return subtitle.contains('Chocolate') ? '5.60' : '5.20';
      case 'Cafetière':
        return subtitle.contains('Strong') ? '4.00' : '3.80';
      default:
        return '4.00';
    }
  }

  Widget _buildCoffeeCard({
    required String image,
    required String title,
    required String subtitle,
    required String price,
  }) {
    return Container(
      width: 170,
      height: 235,
      decoration: BoxDecoration(
        color: AppColors.coffeeTabBarCardBackground,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColors.coffeeTabBarCardShadow,
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10, 11, 10, 0),
                height: 140,
                decoration: BoxDecoration(
                  color: AppColors.coffeeTabBarImageBackground,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.coffeeTabBarImageShadow,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.coffeeTabBarGradientStart,
                              AppColors.coffeeTabBarGradientEnd,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                            height: 120,
                            width: 120,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.coffeeTabBarRatingOverlay,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppColors.coffeeTabBarPromotionBackground,
                        size: 14,
                      ),
                      const SizedBox(width: 3),
                      Text('4.5', style: AppTheme.coffeeTabBarPromotionStyle),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(19, 14, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTheme.coffeeTabBarProductTitleStyle),

                Text(
                  subtitle,
                  style: AppTheme.coffeeTabBarProductSubtitleStyle,
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Text(
                      '\$',
                      style: AppTheme.coffeeTabBarProductPriceCurrencyStyle,
                    ),

                    Text(price, style: AppTheme.coffeeTabBarProductPriceStyle),

                    Padding(
                      padding: const EdgeInsets.only(left: 45),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: AppColors.coffeeAccent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
