class CoffeeItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String image;
  final List<String> sizes;
  final Map<String, double> sizePrices;
  final String category;
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
    required this.category,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'rating': rating,
      'image': image,
      'sizes': sizes,
      'sizePrices': sizePrices,
      'category': category,
      'isFavorite': isFavorite,
    };
  }

  factory CoffeeItem.fromJson(Map<String, dynamic> json) {
    return CoffeeItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      rating: (json['rating'] ?? 0.0).toDouble(),
      image: json['image'] ?? '',
      sizes: List<String>.from(json['sizes'] ?? ['S', 'M', 'L']),
      sizePrices: Map<String, double>.from(
        (json['sizePrices'] ?? {}).map(
          (key, value) => MapEntry(key, value.toDouble()),
        ),
      ),
      category: json['category'] ?? 'espresso',
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  static final CoffeeItem defaultEspresso = CoffeeItem(
    id: 'espresso_1',
    name: 'Espresso',
    description:
        'An espresso is a concentrated form of coffee, served in shots. It is made by forcing very hot water under high pressure through finely-ground coffee beans.',
    price: 4.53,
    rating: 4.5,
    image: 'assets/images/coffee_product.png',
    sizes: ['S', 'M', 'L'],
    sizePrices: {
      'S': 4.53,
      'M': 5.53,
      'L': 6.53,
    },
    category: 'espresso',
    isFavorite: false,
  );
}
