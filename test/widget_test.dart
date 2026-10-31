import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tech_toolkit/main.dart';

void main() {
  testWidgets('home shows both feature cards', (tester) async {
    await tester.pumpWidget(const TechToolkitApp());
    expect(find.text('Stock Average'), findsOneWidget);
    expect(find.text('Compound Interest'), findsOneWidget);
  });

  testWidgets('stock average calculates a report', (tester) async {
    tester.view.physicalSize = const Size(800, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const TechToolkitApp());
    await tester.tap(find.text('Stock Average'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), '100');
    await tester.enterText(fields.at(1), '10');
    await tester.enterText(fields.at(2), '80');
    await tester.enterText(fields.at(3), '10');
    await tester.tap(find.text('Calculate'));
    await tester.pumpAndSettle();

    expect(find.text('₹90.00'), findsWidgets);
    expect(find.text('New average price'), findsOneWidget);
  });
}
