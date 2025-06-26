/// App-wide constants for the coffee shop application
class AppConstants {
  // Prevent instantiation
  AppConstants._();

  // Dimensions
  static const double headerHeight = 413.0;
  static const double imageHeight = 400.0;
  static const double overlayHeight = 123.81;
  static const double overlayContentHeight = 73.81;
  static const double circularButtonSize = 35.0;
  static const double buyButtonHeight = 50.0;
  static const double defaultBorderRadius = 40.0;
  static const double smallBorderRadius = 100.0;
  
  // Spacing
  static const double defaultPadding = 23.0;
  static const double smallPadding = 6.3;
  static const double mediumSpacing = 15.0;
  static const double largeSpacing = 25.0;
  static const double overlayGap = 65.0;
  static const double quantityButtonGap = 26.4;
  
  // Responsive breakpoints
  static const double narrowScreenBreakpoint = 350.0;
  static const double narrowScreenGap = 30.0;
  static const double standardGapSizeQuantity = 54.0;
  static const double standardGapPriceBuy = 63.0;
  
  // Animation durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 200);
  static const Duration fastAnimationDuration = Duration(milliseconds: 100);
  
  // Product data
  static const List<String> chocolateOptions = [
    'White Chocolate',
    'Milk Chocolate',
    'Dark Chocolate',
    'Bittersweet Chocolate',
    'Ruby Chocolate',
  ];
  
  static const List<String> sizeOptions = ['S', 'M', 'L'];
  
  // Product info
  static const String productName = 'Espresso';
  static const String productSubtitle = 'with chocolate';
  static const String productRating = '4.8';
  static const String productReviews = '(6,098)';
  static const String productRoastLevel = 'Medium Roasted';
  static const String productPrice = '4.20';
  
  // Asset paths
  static const String productImagePath = 'assets/images/coffee_product.png';
  static const String backArrowIcon = 'assets/images/back_arrow.svg';
  static const String heartIcon = 'assets/images/heart.svg';
  static const String starIcon = 'assets/images/star.svg';
  static const String coffeeIcon = 'assets/images/coffee.svg';
  static const String dropIcon = 'assets/images/drop.svg';
}
