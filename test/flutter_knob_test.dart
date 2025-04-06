import 'package:flutter_oknob/flutter_oldschool_knob.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/material.dart';

void main() {
  testWidgets('FlutterOKnob widget renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlutterOKnob(
            knobvalue: 50,
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

  testWidgets('FlutterOKnob updates value on pan gesture',
      (WidgetTester tester) async {
    double updatedValue = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlutterOKnob(
            knobvalue: 50,
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

  // testWidgets('FlutterOKnob clamps values between min and max',
  //     (WidgetTester tester) async {
  //   double updatedValue = 0;

  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: Scaffold(
  //         body: FlutterOKnob(
  //           knobvalue: 40,
  //           onChanged: (value) => updatedValue = value,
  //           knobLabel: const Text('Zoom'),
  //           minValue: 0,
  //           maxRotationAngle: 80,
  //         ),
  //       ),
  //     ),
  //   );

  //   await tester.drag(find.byType(GestureDetector), const Offset(40, 0));
  //   await tester.pump();

  //   expect(updatedValue, equals(404)); // Clamped to max value
  // });
}
