import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_oknob/widgets/flutter_widget_painter.dart';
class FlutterOKnob extends StatefulWidget {
  final double knobvalue;
  final ValueChanged<double> onChanged;
  final double size;
  final double? minValue;
  final double? maxValue;
  final Color? markerColor;
  final Gradient? outerRingGradient;
  final Gradient? innerKnobGradient;
  final double sensitivity;
  final Widget? knobLabel;
  final double maxRotationAngle;
  final bool showKnobLabels;
  final double angleOffset;

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
    startAngle = (widget.angleOffset % 360) * pi / 180;
    endAngle = startAngle + 2 * pi;
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  double _angleFromValue(double value) {
    final min = widget.minValue ?? 0;
    final max = widget.maxValue ?? widget.maxRotationAngle;
    return startAngle + ((value - min) / (max - min)) * (endAngle - startAngle);
  }

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
          onPointerSignal: (_) {},
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanUpdate: (details) {
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
                          // Ensure labels reflect the min/max properly in painter too
                        ),
                      ),
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
        if (widget.knobLabel != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: widget.knobLabel!,
          ),
      ],
    );
  }
}
