import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_knob/widgets/flutter_widget_painter.dart';

/// A customizable rotary knob widget for Flutter.
///
/// `FlutterKnob` provides an interactive control with various
/// configuration options such as size, range, colors, gradients,
/// sensitivity, and an optional label.
///
/// ### Features:
/// - Customizable size, value range, and appearance.
/// - Emits changes via the `onChanged` callback.
/// - Optional label widget.
/// - Smooth sensitivity control for better user interaction.
class FlutterKnob extends StatefulWidget {
  /// The current value of the knob. Must be between [minValue] and [maxValue].
  final double value;

  /// A callback triggered whenever the knob value changes.
  /// Receives the updated value as a parameter.
  final ValueChanged<double> onChanged;

  /// The size (diameter) of the knob. Default is `150.0`.
  final double size;

  /// The minimum allowable value for the knob. Default is `0`.
  final double minValue;

  /// The maximum allowable value for the knob. Default is `100`.
  final double maxValue;

  /// The color of the marker that indicates the current position.
  /// If not provided, defaults to `Colors.greenAccent`.
  final Color? markerColor;

  /// The gradient for the outer ring of the knob.
  /// If not provided, defaults to a gradient from black to grey.
  final Gradient? outerRingGradient;

  /// The gradient for the inner knob.
  /// If not provided, defaults to a gradient from grey to black.
  final Gradient? innerKnobGradient;

  /// The sensitivity of the knob to drag gestures.
  /// Higher values make the knob more responsive. Default is `0.5`.
  final double sensitivity;

  /// An optional label widget to display beneath the knob.
  final Widget? knobLabel;

  /// Creates a [FlutterKnob] widget.
  const FlutterKnob({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 150.0,
    this.minValue = 0,
    this.maxValue = 100,
    this.markerColor,
    this.outerRingGradient,
    this.innerKnobGradient,
    this.sensitivity = 0.5,
    this.knobLabel,
  });

  @override
  State<FlutterKnob> createState() => _FlutterKnobState();
}

class _FlutterKnobState extends State<FlutterKnob> {
  /// A notifier for the current knob value. Updates are listened to
  /// and used to redraw the knob UI.
  late ValueNotifier<double> _valueNotifier;

  /// Default gradient for the outer ring.
  static const _defaultOuterRingGradient = LinearGradient(
    colors: [Colors.black, Colors.grey],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Default gradient for the inner knob.
  static const _defaultInnerKnobGradient = LinearGradient(
    colors: [Colors.grey, Colors.black],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Default color for the marker.
  static const _defaultMarkerColor = Colors.greenAccent;

  /// Default color for the label text.
  static const _defaultLabelColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier<double>(widget.value);
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onPanUpdate: (details) {
                final delta = details.delta.dx * widget.sensitivity;
                final newValue = (_valueNotifier.value + delta)
                    .clamp(widget.minValue, widget.maxValue);
                _valueNotifier.value = newValue;
                widget.onChanged(newValue);
              },
              child: ValueListenableBuilder<double>(
                valueListenable: _valueNotifier,
                builder: (context, value, _) {
                  return SizedBox(
                    width: widget.size,
                    height: widget.size,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        /// Outer ring with configurable gradients
                        CustomPaint(
                          size: Size(widget.size, widget.size),
                          painter: FlutterKnobPainter(
                            value: value,
                            minValue: widget.minValue,
                            maxValue: widget.maxValue,
                            markerColor:
                                widget.markerColor ?? _defaultMarkerColor,
                            outerRingGradient: widget.outerRingGradient ??
                                _defaultOuterRingGradient,
                            innerKnobGradient: widget.innerKnobGradient ??
                                _defaultInnerKnobGradient,
                          ),
                        ),

                        /// Current value displayed near the knob's edge
                        Positioned(
                          left: widget.size / 2 +
                              cos(_calculateAngle(value)) * widget.size / 3.5,
                          top: widget.size / 2 +
                              sin(_calculateAngle(value)) * widget.size / 3.5,
                          child: Text(
                            value.toStringAsFixed(0),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _defaultLabelColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        /// Optional label widget
        if (widget.knobLabel != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: widget.knobLabel!,
          ),
      ],
    );
  }

  /// Converts the current value to a gauge-style angle in radians.
  double _calculateAngle(double value) {
    final normalizedValue =
        (value - widget.minValue) / (widget.maxValue - widget.minValue);
    return normalizedValue * pi - pi;
  }
}
