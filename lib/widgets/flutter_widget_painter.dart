import 'dart:math';

import 'package:flutter/material.dart';

// class FlutterKnobPainter extends CustomPainter {
//   final double value;
//   final double minValue;
//   final double maxValue;
//   final Color markerColor;
//   final Gradient outerRingGradient;
//   final Gradient innerKnobGradient;

//   FlutterKnobPainter({
//     required this.value,
//     required this.minValue,
//     required this.maxValue,
//     required this.markerColor,
//     required this.outerRingGradient,
//     required this.innerKnobGradient,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint outerRingPaint = Paint()
//       ..shader = outerRingGradient.createShader(
//         Rect.fromCircle(
//           center: Offset(size.width / 2, size.height / 2),
//           radius: size.width / 2,
//         ),
//       )
//       ..style = PaintingStyle.fill;

//     final Paint innerKnobPaint = Paint()
//       ..shader = innerKnobGradient.createShader(
//         Rect.fromCircle(
//           center: Offset(size.width / 2, size.height / 2),
//           radius: size.width / 2.5,
//         ),
//       )
//       ..style = PaintingStyle.fill;

//     final Paint markerPaint = Paint()
//       ..color = markerColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0;

//     // Draw outer ring
//     canvas.drawCircle(
//       Offset(size.width / 2, size.height / 2),
//       size.width / 2,
//       outerRingPaint,
//     );

//     // Draw inner knob
//     canvas.drawCircle(
//       Offset(size.width / 2, size.height / 2),
//       size.width / 2.5,
//       innerKnobPaint,
//     );

//     // Draw marker
//     final normalizedValue = (value - minValue) / (maxValue - minValue);
//     final double angle = normalizedValue * 2 * pi + pi; // Start at 9 o'clock
//     final Offset markerStart = Offset(
//       size.width / 2 + cos(angle) * size.width / 3.5,
//       size.height / 2 + sin(angle) * size.height / 3.5,
//     );
//     final Offset markerEnd = Offset(
//       size.width / 2 + cos(angle) * size.width / 2.5,
//       size.height / 2 + sin(angle) * size.width / 2.5,
//     );

//     canvas.drawLine(markerStart, markerEnd, markerPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }



class FlutterKnobPainter extends CustomPainter {
  final double value;
  final double minValue;
  final double maxValue;
  final Color markerColor;
  final Gradient outerRingGradient;
  final Gradient innerKnobGradient;

  FlutterKnobPainter({
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.markerColor,
    required this.outerRingGradient,
    required this.innerKnobGradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint outerRingPaint = Paint()
      ..shader = outerRingGradient.createShader(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2,
        ),
      )
      ..style = PaintingStyle.fill;

    final Paint innerKnobPaint = Paint()
      ..shader = innerKnobGradient.createShader(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2.5,
        ),
      )
      ..style = PaintingStyle.fill;

    final Paint markerPaint = Paint()
      ..color = markerColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw outer ring
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      outerRingPaint,
    );

    // Draw inner knob
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2.5,
      innerKnobPaint,
    );

    // Draw marker
    final normalizedValue = (value - minValue) / (maxValue - minValue);
    final double angle = normalizedValue * pi - pi; // Gauge-style angle
    final Offset markerStart = Offset(
      size.width / 2 + cos(angle) * size.width / 3.5,
      size.height / 2 + sin(angle) * size.height / 3.5,
    );
    final Offset markerEnd = Offset(
      size.width / 2 + cos(angle) * size.width / 2.5,
      size.height / 2 + sin(angle) * size.width / 2.5,
    );

    canvas.drawLine(markerStart, markerEnd, markerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
