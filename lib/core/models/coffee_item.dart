class CoffeeItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String image;
  final List<String> sizes;
  final Map<String, double> sizePrices;
  bool isFavorite = false;

  CoffeeItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.image,
    required this.sizes,
    required this.sizePrices,
    this.isFavorite = false,
  });

  // Default espresso product
  static final CoffeeItem defaultEspresso = CoffeeItem(
    id: 'espresso_1',
    name: 'Espresso',
    description: 'An espresso is a concentrated form of coffee, served in shots. It is made by forcing very hot water under high pressure through finely-ground coffee beans.',
    price: 4.53,
    rating: 4.5,
    image: 'assets/images/coffee_product.png',
    sizes: ['S', 'M', 'L'],
    sizePrices: {
      'S': 4.53,
      'M': 5.53,
      'L': 6.53,
    },
    isFavorite: false,
  );
}
