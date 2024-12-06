import 'package:flutter_knob/flutter_knob.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/material.dart';

void main() {
  testWidgets('FlutterKnob widget renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlutterKnob(
            value: 50,
            onChanged: (_) {},
            knobLabel: const Text('Volume: 50%'),
          ),
        ),
      ),
    );

    expect(find.text('Volume: 50%'), findsOneWidget);
    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.byType(CustomPaint), findsNWidgets(2));
  });

  testWidgets('FlutterKnob updates value on pan gesture',
      (WidgetTester tester) async {
    double updatedValue = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlutterKnob(
            value: 50,
            onChanged: (value) => updatedValue = value,
            knobLabel: const Text('Brightness'),
          ),
        ),
      ),
    );

    await tester.drag(find.byType(GestureDetector), const Offset(10, 0));
    await tester.pump();

    expect(updatedValue, greaterThan(50));
  });

  testWidgets('FlutterKnob clamps values between min and max',
      (WidgetTester tester) async {
    double updatedValue = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlutterKnob(
            value: 90,
            onChanged: (value) => updatedValue = value,
            knobLabel: const Text('Zoom'),
            minValue: 20,
            maxValue: 80,
          ),
        ),
      ),
    );

    await tester.drag(find.byType(GestureDetector), const Offset(100, 0));
    await tester.pump();

    expect(updatedValue, equals(80)); // Clamped to max value
  });
}