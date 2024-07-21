import 'package:autopulse/ui/PagesScreen.dart';
import 'package:autopulse/welcome_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:autopulse/main.dart';

void main() {
  testWidgets('App starts with LoginScreen when isLoggedIn is false',
      (WidgetTester tester) async {
    // Build our app and trigger a frame with isLoggedIn set to false.
    await tester.pumpWidget(MyApp(isLoggedIn: false));

    // Verify that the LoginScreen is displayed.
    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('App starts with PagesScreen when isLoggedIn is true',
      (WidgetTester tester) async {
    // Build our app and trigger a frame with isLoggedIn set to true.
    await tester.pumpWidget(MyApp(isLoggedIn: true));

    // Verify that the PagesScreen is displayed.
    expect(find.byType(PagesScreen), findsOneWidget);
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame with isLoggedIn set to false.
    await tester.pumpWidget(MyApp(isLoggedIn: false));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
