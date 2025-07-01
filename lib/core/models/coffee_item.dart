class CoffeeItem {
  final String name;
  final String description;
  final double price;
  final double rating;
  final String image;
  bool isFavorite = false;

  CoffeeItem(
      {required this.name,
      required this.description,
      required this.price,
      required this.rating,
      required this.image,
      this.isFavorite = false});
}
