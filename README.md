
# FlutterOKnob Widget Documentation

## Overview:
**Description:**

The `FlutterOKnob` widget provides a customizable rotary knob that can be used for various controls, such as adjusting volume, brightness, or any other value within a specified range. This widget is interactive, supports various styling options, and provides smooth performance, making it suitable for a variety of applications.

<img width="330" alt="Screenshot 2024-12-06 at 16 22 09" src="https://github.com/user-attachments/assets/2345dd47-979b-42c1-8a43-ced40d0d32f7">
<img width="330" alt="Screenshot 2024-12-06 at 16 21 57" src="https://github.com/user-attachments/assets/d73f3e32-da00-489d-bf38-d94685094537">
<img width="330" alt="Screenshot 2024-12-06 at 16 10 31" src="https://github.com/user-attachments/assets/711e0fd5-8bde-4995-b822-d01a40be0f7b">

## Features:
- **Interactive Control**: Allows users to drag and adjust values in a specified range.
- **Customizable Appearance**: Support for size, color, gradients, sensitivity, and more.
- **Value Tracking**: Emits changes through the `onChanged` callback for external handling.
- **Optional Label**: Allows display of a custom label beneath the knob for added context.
- **Smooth Performance**: Optimized for smooth interaction and visual updates.

## Dependencies:
- Flutter SDK (ensure that your project is configured to use Flutter 3.0 or above).

## Installation:
**Steps:**

- Add the FlutterOKnob widget to your Flutter project dependencies in your `pubspec.yaml` file.
- Import the widget into your Dart file using:

```dart
import 'package:flutter_knob/flutter_oldschool_knob.dart';
```

```yaml
dependencies:
  flutter_oknob: ^0.0.3
```

## Usage Example:
**Description:**

Here is an example of how to use the `FlutterOKnob` widget in your Flutter application. The widget supports customizable properties such as size, gradients, marker color, sensitivity, and a custom label.

```dart
FlutterOKnob(
  value: 50.0,
  onChanged: (newValue) {
    print('Knob value changed: $newValue');
  },
  size: 200.0,
  minValue: 0.0,
  maxValue: 100.0,
  outerRingGradient: LinearGradient(
    colors: [Colors.blue, Colors.purple],
  ),
  innerKnobGradient: LinearGradient(
    colors: [Colors.orange, Colors.red],
  ),
  markerColor: Colors.green,
  knobLabel: Text(
    'Volume',
    style: TextStyle(color: Colors.white, fontSize: 18.0),
  ),
);
```

## Parameters:
**Description:**

The following table outlines the customizable parameters that control the behavior and appearance of the `FlutterOKnob` widget. Each parameter has a default value, but all can be modified to fit the needs of your specific implementation.

| Name              | Type                    | Default                             | Description |
|-------------------|-------------------------|-------------------------------------|-------------|
| `value`           | `double`                | —                                   | The current value of the knob. Must be between `minValue` and `maxValue`. |
| `onChanged`       | `ValueChanged<double>`  | —                                   | Callback triggered on value change. |
| `size`            | `double`                | `150.0`                              | Diameter of the knob in pixels. |
| `minValue`        | `double`                | `0.0`                                | Minimum value. |
| `maxValue`        | `double`                | `100.0`                              | Maximum value. |
| `markerColor`     | `Color`                 | `Colors.greenAccent`                | Color of the value marker. |
| `outerRingGradient` | `Gradient`            | `LinearGradient([black, grey])`     | Gradient for the outer ring. |
| `innerKnobGradient` | `Gradient`            | `LinearGradient([grey, black])`     | Gradient for the inner knob. |
| `sensitivity`     | `double`                | `0.5`                                | Drag sensitivity. |
| `knobLabel`       | `Widget?`               | `null`                               | Optional label below the knob. |

## How It Works:
**Description:**

The `FlutterOKnob` widget listens to drag gestures (`onPanUpdate`). As the user drags, the value updates based on the direction and speed of the gesture. This value is clamped between `minValue` and `maxValue`, then passed to the `onChanged` callback and rendered visually.

### Rendering with `FlutterKnobPainter`:

The visual representation is powered by `FlutterKnobPainter`, a `CustomPainter` that draws:

- **Outer Ring**: A circle filled with a customizable gradient.
- **Inner Knob**: A smaller circle, also gradient-filled, inside the ring.
- **Value Marker**: A line that points to the current value based on angle calculations.
- **Value Labels**: Optional numerical labels spaced evenly around the knob.

The angle is calculated based on the clamped value and interpolated between `startAngle` and `endAngle`. When `showLabels` is true, labels from 0 to the max `rotation` are drawn around the perimeter using `TextPainter`.

Repaint only occurs when any of the critical visual or state parameters (e.g., value, gradients, min/max, rotation) change — keeping performance optimal.

## Customization Options:
**Description:**

The `FlutterOKnob` widget provides several options to customize its appearance and behavior. These options allow you to tailor the widget to fit your app’s design and functional needs.

### `outerRingGradient`
Customize the outer ring's gradient:

```dart
outerRingGradient: LinearGradient(
  colors: [Colors.blue, Colors.cyan],
)
```

### `innerKnobGradient`
Customize the inner knob’s appearance:

```dart
innerKnobGradient: LinearGradient(
  colors: [Colors.orange, Colors.yellow],
)
```

### `markerColor`
Change the color of the marker that indicates the current value:

```dart
markerColor: Colors.red
```

### `sensitivity`
Adjust the sensitivity to user drag gestures:

```dart
sensitivity: 0.8
```

### `knobLabel`
Add a label under the knob:

```dart
knobLabel: Text(
  'Volume',
  style: TextStyle(color: Colors.white, fontSize: 16),
)
```

## Notes:
- Ensure that the initial value (`value`) is within the range defined by `minValue` and `maxValue` to avoid unexpected behavior.
- For better UI consistency, customize the gradients, sensitivity, and marker color to match your app.
- The widget adapts well to different screen resolutions.

## Contribution:
If you'd like to contribute or report issues, feel free to open a pull request or an issue on the repository. Contributions such as bug fixes, performance improvements, and feature requests are always welcome.

## License:
**License:** MIT  
This project is licensed under the MIT License. See the LICENSE file for details.
