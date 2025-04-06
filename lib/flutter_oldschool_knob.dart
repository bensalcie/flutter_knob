import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_oknob/widgets/flutter_widget_painter.dart';

/// A customizable rotary knob widget, similar to analog audio knobs.
///
/// `FlutterOKnob` allows users to rotate a knob to select a value within a
/// given range. It supports styling via gradients, markers, labels, and
/// rotation sensitivity.
class FlutterOKnob extends StatefulWidget {
  /// The current value of the knob.
  final double knobvalue;

  /// Callback invoked when the knob value changes.
  final ValueChanged<double> onChanged;

  /// The overall diameter of the knob widget.
  final double size;

  /// The minimum allowed value for the knob. Defaults to 0.
  final double? minValue;

  /// The maximum allowed value for the knob. Defaults to [maxRotationAngle].
  final double? maxValue;

  /// Color of the value marker on the knob.
  final Color? markerColor;

  /// Gradient used for the outer ring of the knob.
  final Gradient? outerRingGradient;

  /// Gradient used for the inner knob.
  final Gradient? innerKnobGradient;

  /// Sensitivity factor for knob rotation. Not currently used in this version.
  final double sensitivity;

  /// Optional widget to be displayed below the knob as a label.
  final Widget? knobLabel;

  /// The maximum rotation angle (in degrees) allowed for the knob. Defaults to 360°.
  final double maxRotationAngle;

  /// If true, shows numerical value markers on the knob.
  final bool showKnobLabels;

  /// The starting angle offset in degrees. Default is 90° (pointing up).
  final double angleOffset;

  /// Creates a [FlutterOKnob] widget.
  const FlutterOKnob({
    super.key,
    required this.knobvalue,
    required this.onChanged,
    this.size = 150.0,
    this.minValue,
    this.maxValue,
    this.markerColor,
    this.outerRingGradient,
    this.innerKnobGradient,
    this.sensitivity = 0.5,
    this.knobLabel,
    this.maxRotationAngle = 360,
    this.showKnobLabels = true,
    this.angleOffset = 90,
  });

  @override
  State<FlutterOKnob> createState() => _FlutterOKnobState();
}

class _FlutterOKnobState extends State<FlutterOKnob> {
  late ValueNotifier<double> _valueNotifier;

  // Default styling values
  static const _defaultOuterRingGradient = LinearGradient(
    colors: [Colors.black, Colors.grey],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const _defaultInnerKnobGradient = LinearGradient(
    colors: [Colors.grey, Colors.black],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const _defaultMarkerColor = Colors.greenAccent;
  static const _defaultLabelColor = Colors.white;

  late final double startAngle;
  late final double endAngle;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier<double>(widget.knobvalue);

    // Convert angle offset to radians for calculation
    startAngle = (widget.angleOffset % 360) * pi / 180;
    endAngle = startAngle + 2 * pi;
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  /// Converts a given value to an angle in radians based on min and max.
  double _angleFromValue(double value) {
    final min = widget.minValue ?? 0;
    final max = widget.maxValue ?? widget.maxRotationAngle;
    return startAngle + ((value - min) / (max - min)) * (endAngle - startAngle);
  }

  /// Converts a given angle in radians to a value based on min and max.
  double _valueFromAngle(double angle) {
    final min = widget.minValue ?? 0;
    final max = widget.maxValue ?? widget.maxRotationAngle;
    final normalized = (angle - startAngle) % (2 * pi);
    final value = min + (normalized / (endAngle - startAngle)) * (max - min);
    return value.clamp(min, max);
  }

  @override
  Widget build(BuildContext context) {
    final min = widget.minValue ?? 0;
    final max = widget.maxValue ?? widget.maxRotationAngle;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Listener(
          onPointerSignal: (_) {}, // Reserved for future use
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanUpdate: (details) {
              // Detect dragging to update value
              RenderBox renderBox = context.findRenderObject() as RenderBox;
              final offset = renderBox.globalToLocal(details.globalPosition);
              final center = Offset(widget.size / 2, widget.size / 2);
              final angle = atan2(offset.dy - center.dy, offset.dx - center.dx);
              final newValue = _valueFromAngle(angle);
              _valueNotifier.value = newValue;
              widget.onChanged(newValue);
            },
            child: ValueListenableBuilder<double>(
              valueListenable: _valueNotifier,
              builder: (context, value, _) {
                final angle = _angleFromValue(value);

                return SizedBox(
                  width: widget.size,
                  height: widget.size,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      /// Custom painter that draws the knob rings and labels.
                      CustomPaint(
                        size: Size(widget.size, widget.size),
                        painter: FlutterKnobPainter(
                          value: value,
                          minValue: min,
                          maxValue: max,
                          markerColor:
                              widget.markerColor ?? _defaultMarkerColor,
                          outerRingGradient: widget.outerRingGradient ??
                              _defaultOuterRingGradient,
                          innerKnobGradient: widget.innerKnobGradient ??
                              _defaultInnerKnobGradient,
                          startAngle: startAngle,
                          endAngle: endAngle,
                          showLabels: widget.showKnobLabels,
                          rotation: widget.maxRotationAngle,
                        ),
                      ),

                      /// Marker showing current value position and value
                      Positioned(
                        left: widget.size / 2 +
                            cos(angle) * widget.size / 3.5 -
                            10,
                        top: widget.size / 2 +
                            sin(angle) * widget.size / 3.5 -
                            10,
                        child: Column(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color:
                                    widget.markerColor ?? _defaultMarkerColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              value.toStringAsFixed(0),
                              style: const TextStyle(
                                fontSize: 10,
                                color: _defaultLabelColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),

        /// Optional knob label displayed below the knob
        if (widget.knobLabel != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: widget.knobLabel!,
          ),
      ],
    );
  }
}
