import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otej_link/main.dart';

void main() {
  testWidgets('App smoke test — OtejApp renders without crash',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: OtejApp()),
    );
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
