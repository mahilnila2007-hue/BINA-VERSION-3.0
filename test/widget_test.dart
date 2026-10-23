// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rehabrep/main.dart';

void main() {
  testWidgets('ReHabRepApp smoke test renders design system showcase', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: ReHabRepApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify that the title and counter are rendered
    expect(find.text('ReHabRep Design System'), findsOneWidget);
    expect(find.text('LIVE REP COUNTER (96sp+)'), findsOneWidget);

    // Scroll to the button and verify it renders
    await tester.scrollUntilVisible(
      find.text('START EXERCISE'),
      200.0,
      scrollable: find.byType(Scrollable),
    );
    expect(find.text('START EXERCISE'), findsOneWidget);
  });
}
