import 'dart:math';

import 'package:flutter/material.dart';

class FlutterKnobPainter extends CustomPainter {
  final double value;
  final double minValue;
  final double maxValue;
  final Color markerColor;
  final Gradient outerRingGradient;
  final Gradient innerKnobGradient;
  final double startAngle;
  final double endAngle;
  final double rotation;
  final bool showLabels;

  FlutterKnobPainter({
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.markerColor,
    required this.outerRingGradient,
    required this.innerKnobGradient,
    required this.startAngle,
    required this.endAngle,
    required this.rotation,
    required this.showLabels,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final Paint outerRingPaint = Paint()
      ..shader = outerRingGradient.createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;

    final Paint innerKnobPaint = Paint()
      ..shader = innerKnobGradient.createShader(Rect.fromCircle(center: center, radius: radius * 0.7))
      ..style = PaintingStyle.fill;

    final Paint markerPaint = Paint()
      ..color = markerColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw outer ring
    canvas.drawCircle(center, radius, outerRingPaint);

    // Draw inner knob
    canvas.drawCircle(center, radius * 0.7, innerKnobPaint);

    // Calculate the angle from value
    final clamped = value.clamp(minValue, maxValue);
    final double angle = startAngle + (clamped / rotation) * (endAngle - startAngle);

    final Offset markerStart = Offset(
      center.dx + cos(angle) * radius * 0.6,
      center.dy + sin(angle) * radius * 0.6,
    );
    final Offset markerEnd = Offset(
      center.dx + cos(angle) * radius * 0.7,
      center.dy + sin(angle) * radius * 0.7,
    );

    canvas.drawLine(markerStart, markerEnd, markerPaint);

    if (showLabels) {
      const labelStyle = TextStyle(
        fontSize: 10,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      );
      const labelCount = 12;
      for (int i = 0; i <= labelCount; i++) {
        final double t = i / labelCount;
        final labelAngle = startAngle + t * (endAngle - startAngle);
        final labelValue = (t * rotation).round();
        final dx = center.dx + cos(labelAngle) * radius * 0.85;
        final dy = center.dy + sin(labelAngle) * radius * 0.85;

        final tp = TextPainter(
          text: TextSpan(text: labelValue.toString(), style: labelStyle),
          textDirection: TextDirection.ltr,
        );
        tp.layout();
        tp.paint(canvas, Offset(dx - tp.width / 2, dy - tp.height / 2));
      }
    }
  }

  @override
  bool shouldRepaint(covariant FlutterKnobPainter oldDelegate) {
    return value != oldDelegate.value ||
        minValue != oldDelegate.minValue ||
        maxValue != oldDelegate.maxValue ||
        markerColor != oldDelegate.markerColor ||
        outerRingGradient != oldDelegate.outerRingGradient ||
        innerKnobGradient != oldDelegate.innerKnobGradient ||
        startAngle != oldDelegate.startAngle ||
        endAngle != oldDelegate.endAngle ||
        rotation != oldDelegate.rotation ||
        showLabels != oldDelegate.showLabels;
  }
}
