// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_mobile_intern/viewmodels/second_screen_provider.dart';

import 'package:suitmedia_mobile_intern/views/screens/second_screen.dart';

void main() {
  testWidgets(
    'Second Screen UI',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => SecondScreenProvider(),
            ),
          ],
          child: const MaterialApp(
            home: SecondScreen(args: {}),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.pump();

      expect(find.text("Second Screen"), findsOneWidget);
      expect(find.text("Welcome"), findsOneWidget);
      expect(find.text("Tracey Ramos"), findsNothing);
    },
  );
}
