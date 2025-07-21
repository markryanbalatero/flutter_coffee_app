// This is a basic Flutter widget test for the Coffee App.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_coffee_app/main.dart';

void main() {
  testWidgets('Coffee app loads without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for any loading states to complete
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Verify that the app loads without throwing errors
    // Just check that we have a scaffold (basic app structure)
    expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
  });
}
