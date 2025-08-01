 import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageUtils {
  static bool isBase64Image(String imagePath) {
    return imagePath.startsWith('data:image/') ||
        (imagePath.length > 100 && !imagePath.startsWith('assets/'));
  }

  static Uint8List? base64ToBytes(String base64String) {
    try {
      String cleanBase64 = base64String;
      if (base64String.contains(',')) {
        cleanBase64 = base64String.split(',').last;
      }

      return base64Decode(cleanBase64);
    } catch (e) {
      print('Error converting base64 to bytes: $e');
      return null;
    }
  }

  static ImageProvider getImageProvider(String imagePath) {
    if (isBase64Image(imagePath)) {
      final bytes = base64ToBytes(imagePath);
      if (bytes != null) {
        return MemoryImage(bytes);
      } else {
        return const AssetImage('assets/images/coffee_default.png');
      }
    } else {
      return AssetImage(imagePath);
    }
  }
  static Widget buildImage({
    required String imagePath,
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
    BorderRadius? borderRadius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        image: DecorationImage(
          image: getImageProvider(imagePath),
          fit: fit,
        ),
      ),
    );
  }
}
