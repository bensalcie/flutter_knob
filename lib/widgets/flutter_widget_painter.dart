import 'dart:math';

import 'package:flutter/material.dart';

/// A [CustomPainter] responsible for rendering the visual appearance of the knob.
///
/// It draws the outer ring, the inner knob, a marker indicating the current value,
/// and optionally value labels around the knob.
class FlutterKnobPainter extends CustomPainter {
  /// Current value to be represented by the knob.
  final double value;

  /// The minimum possible value for the knob.
  final double minValue;

  /// The maximum possible value for the knob.
  final double maxValue;

  /// The color used to paint the value marker.
  final Color markerColor;

  /// The gradient used for the outer ring of the knob.
  final Gradient outerRingGradient;

  /// The gradient used for the inner circle of the knob.
  final Gradient innerKnobGradient;

  /// The starting angle (in radians) for the knob’s rotation.
  final double startAngle;

  /// The ending angle (in radians) for the knob’s rotation.
  final double endAngle;

  /// The maximum rotation value that maps to the full sweep of the knob.
  final double rotation;

  /// Whether to show value labels around the knob.
  final bool showLabels;

  /// Creates a [FlutterKnobPainter] to render the knob widget.
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

    // Paint for the outer ring of the knob.
    final Paint outerRingPaint = Paint()
      ..shader = outerRingGradient
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;

    // Paint for the inner knob circle.
    final Paint innerKnobPaint = Paint()
      ..shader = innerKnobGradient
          .createShader(Rect.fromCircle(center: center, radius: radius * 0.7))
      ..style = PaintingStyle.fill;

    // Paint for the marker line indicating the current value.
    final Paint markerPaint = Paint()
      ..color = markerColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw the outer ring.
    canvas.drawCircle(center, radius, outerRingPaint);

    // Draw the inner knob.
    canvas.drawCircle(center, radius * 0.7, innerKnobPaint);

    // Clamp the value to stay within min and max bounds.
    final clamped = value.clamp(minValue, maxValue);

    // Calculate angle corresponding to the current value.
    final double angle =
        startAngle + (clamped / rotation) * (endAngle - startAngle);

    // Compute start and end points of the marker line.
    final Offset markerStart = Offset(
      center.dx + cos(angle) * radius * 0.6,
      center.dy + sin(angle) * radius * 0.6,
    );
    final Offset markerEnd = Offset(
      center.dx + cos(angle) * radius * 0.7,
      center.dy + sin(angle) * radius * 0.7,
    );

    // Draw the marker line.
    canvas.drawLine(markerStart, markerEnd, markerPaint);

    // Draw numerical labels if enabled.
    if (showLabels) {
      const labelStyle = TextStyle(
        fontSize: 10,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      );
      const labelCount = 12;

      // Draw 12 evenly spaced labels around the knob.
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

        // Center each label around its position.
        tp.paint(canvas, Offset(dx - tp.width / 2, dy - tp.height / 2));
      }
    }
  }

  /// Determines whether the knob should be repainted.
  ///
  /// Repaints only if relevant visual or value properties change.
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
