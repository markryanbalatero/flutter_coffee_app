import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'dart:convert';
import '../core/models/coffee_item.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _coffeeCollection = 'coffees';

  static Future<void> testConnection() async {
    try {
      await _firestore.collection('test').limit(1).get();

      await _firestore.collection('test').doc('connection').set(
          {'timestamp': FieldValue.serverTimestamp(), 'status': 'connected'});
    } catch (e) {
      throw Exception('Firestore connection failed: $e');
    }
  }

  static Future<String> _convertImageToBase64(File imageFile) async {
    try {
      if (!await imageFile.exists()) {
        throw Exception('Image file does not exist at path: ${imageFile.path}');
      }

      final bytes = await imageFile.readAsBytes();

      if (bytes.length > 800 * 1024) {
        throw Exception(
            'Image too large (${bytes.length} bytes). Please use a smaller image (max 800KB).');
      }

      final base64String = base64Encode(bytes);
      return base64String;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> addCoffee({
    required CoffeeItem coffee,
    File? imageFile,
  }) async {
    try {
      String imageBase64 = '';

      if (imageFile != null) {
        imageBase64 = await _convertImageToBase64(imageFile);
      }

      final coffeeData = {
        'id': coffee.id,
        'name': coffee.name,
        'description': coffee.description,
        'price': coffee.price,
        'imageBase64': imageBase64,
        'rating': coffee.rating,
        'isFavorite': coffee.isFavorite,
        'sizes': coffee.sizes,
        'sizePrices': coffee.sizePrices,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await _firestore
          .collection(_coffeeCollection)
          .doc(coffee.id)
          .set(coffeeData);

      return coffee.id;
    } catch (e) {
      throw Exception('Failed to add coffee to Firestore: $e');
    }
  }

  static Future<List<CoffeeItem>> getAllCoffees() async {
    try {
      final querySnapshot = await _firestore
          .collection(_coffeeCollection)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return CoffeeItem(
          id: data['id'] ?? '',
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          price: (data['price'] ?? 0).toDouble(),
          image: data['imageBase64'] ?? '',
          rating: (data['rating'] ?? 0).toDouble(),
          isFavorite: data['isFavorite'] ?? false,
          sizes: List<String>.from(data['sizes'] ?? []),
          sizePrices: Map<String, double>.from(
            (data['sizePrices'] ?? {}).map(
              (key, value) => MapEntry(key, value.toDouble()),
            ),
          ),
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to get coffees from Firestore: $e');
    }
  }

  static Future<void> updateCoffee({
    required String coffeeId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      updates['updatedAt'] = FieldValue.serverTimestamp();

      await _firestore
          .collection(_coffeeCollection)
          .doc(coffeeId)
          .update(updates);
    } catch (e) {
      throw Exception('Failed to update coffee: $e');
    }
  }

  static Future<void> deleteCoffee(String coffeeId) async {
    try {
      await _firestore.collection(_coffeeCollection).doc(coffeeId).delete();
    } catch (e) {
      throw Exception('Failed to delete coffee: $e');
    }
  }

  static Stream<List<CoffeeItem>> getCoffeesStream() {
    return _firestore
        .collection(_coffeeCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return CoffeeItem(
          id: data['id'] ?? '',
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          price: (data['price'] ?? 0).toDouble(),
          image: data['imageBase64'] ?? '',
          rating: (data['rating'] ?? 0).toDouble(),
          isFavorite: data['isFavorite'] ?? false,
          sizes: List<String>.from(data['sizes'] ?? []),
          sizePrices: Map<String, double>.from(
            (data['sizePrices'] ?? {}).map(
              (key, value) => MapEntry(key, value.toDouble()),
            ),
          ),
        );
      }).toList();
    });
  }
}
