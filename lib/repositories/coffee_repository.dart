import 'dart:io';
import '../core/models/coffee_item.dart';
import '../services/firestore_service.dart';

/// Repository for managing coffee data operations
class CoffeeRepository {
  
  /// Adds a new coffee to the database
  static Future<String> addCoffee({
    required CoffeeItem coffee,
    required String imageFilePath,
  }) async {
    return await FirestoreService.addCoffee(
      coffee: coffee,
      imageFile: imageFilePath.isNotEmpty ? 
        File(imageFilePath) : null,
    );
  }

  /// Gets all coffees from the database
  static Future<List<CoffeeItem>> getAllCoffees() async {
    return await FirestoreService.getAllCoffees();
  }

  /// Gets real-time stream of coffees
  static Stream<List<CoffeeItem>> getCoffeesStream() {
    return FirestoreService.getCoffeesStream();
  }

  /// Updates an existing coffee
  static Future<void> updateCoffee({
    required String coffeeId,
    required Map<String, dynamic> updates,
  }) async {
    return await FirestoreService.updateCoffee(
      coffeeId: coffeeId,
      updates: updates,
    );
  }

  /// Deletes a coffee
  static Future<void> deleteCoffee(String coffeeId) async {
    return await FirestoreService.deleteCoffee(coffeeId);
  }

  /// Toggles favorite status of a coffee
  static Future<void> toggleFavorite(String coffeeId, bool isFavorite) async {
    return await FirestoreService.updateCoffee(
      coffeeId: coffeeId,
      updates: {'isFavorite': !isFavorite},
    );
  }

  /// Updates coffee rating
  static Future<void> updateRating(String coffeeId, double rating) async {
    return await FirestoreService.updateCoffee(
      coffeeId: coffeeId,
      updates: {'rating': rating},
    );
  }
}
