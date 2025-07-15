import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class Base64Image extends StatelessWidget {
  final String base64String;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const Base64Image({
    super.key,
    required this.base64String,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (base64String.isEmpty) {
      return placeholder ??
          Container(
            width: width,
            height: height,
            color: Colors.grey[300],
            child: const Icon(Icons.coffee, color: Colors.grey, size: 40),
          );
    }

    try {
      // Decode Base64 string to bytes
      final Uint8List bytes = base64Decode(base64String);

      return Image.memory(
        bytes,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ??
              Container(
                width: width,
                height: height,
                color: Colors.red[100],
                child: const Icon(Icons.error, color: Colors.red),
              );
        },
      );
    } catch (e) {
      // Handle decoding errors
      return errorWidget ??
          Container(
            width: width,
            height: height,
            color: Colors.red[100],
            child: const Icon(Icons.broken_image, color: Colors.red),
          );
    }
  }
}

/// Extension to easily convert Base64 string to Image widget
extension Base64ImageExtension on String {
  Widget toImage({
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return Base64Image(
      base64String: this,
      width: width,
      height: height,
      fit: fit,
      placeholder: placeholder,
      errorWidget: errorWidget,
    );
  }
}
