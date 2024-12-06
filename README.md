# FlutterOKnob Widget Documentation

## Overview:
  Description: |
    The FlutterKnob widget provides a customizable rotary knob that can be used for various controls, such as adjusting volume, brightness, or any other value within a specified range. This widget is interactive, supports various styling options, and provides smooth performance, making it suitable for a variety of applications.

<img width="330" alt="Screenshot 2024-12-06 at 16 22 09" src="https://github.com/user-attachments/assets/2345dd47-979b-42c1-8a43-ced40d0d32f7">
<img width="330" alt="Screenshot 2024-12-06 at 16 21 57" src="https://github.com/user-attachments/assets/d73f3e32-da00-489d-bf38-d94685094537">
<img width="330" alt="Screenshot 2024-12-06 at 16 10 31" src="https://github.com/user-attachments/assets/711e0fd5-8bde-4995-b822-d01a40be0f7b">

    

## Features:
  - Interactive Control: Allows users to drag and adjust values in a specified range.
  - Customizable Appearance: Support for size, color, gradients, sensitivity, and more.
  - Value Tracking: Emits changes through the `onChanged` callback for external handling.
  - Optional Label: Allows display of a custom label beneath the knob for added context.
  - Smooth Performance: Optimized for smooth interaction and visual updates.

## Dependencies:
  - Flutter SDK (ensure that your project is configured to use Flutter 3.0 or above).

## Installation:
  steps:
    - Add the FlutterKnob widget to your Flutter project dependencies in your `pubspec.yaml` file.
    - Import the widget into your Dart file using the following import statement:

     
      import 'import 'package:flutter_knob/flutter_oldschool_knob.dart';


      dependencies:
        flutter_oknob: ^0.0.3
     

## Usage Example:
  Description: |
    Here is an example of how to use the `FlutterOKnob` widget in your Flutter application. 
    The widget supports customizable properties such as size, gradients, marker color, sensitivity, and a custom label.

  Example: 
  
    
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
   

## Parameters:
  Description: |
    The following table outlines the customizable parameters that control the behavior and appearance of the `FlutterOKnob` widget. Each parameter has a default value, but all can be modified to fit the needs of your specific implementation.

  parameters:
     
     value:
        type: double
        description: |
          The current value of the knob, which should be between the `minValue` and `maxValue`. It is required for the widget to work properly.
        required: true
      onChanged:
        type: ValueChanged<double>
        description: |
          A callback function that is triggered when the knob's value changes. It passes the new value as an argument.
        required: true
      size:
        type: double
        default: 150.0
        description: |
          The diameter of the knob (in pixels). This determines the size of the knob on the screen.
      minValue:
        type: double
        default: 0.0
        description: |
          The minimum possible value that the knob can be set to.
      maxValue:
        type: double
        default: 100.0
        description: |
          The maximum possible value that the knob can be set to.
      markerColor:
        type: Color
        default: Colors.greenAccent
        description: |
          The color of the marker that indicates the current value on the knob.
      outerRingGradient:
        type: Gradient
        default: |
          LinearGradient(colors: [Colors.black, Colors.grey], begin: Alignment.topLeft, end: Alignment.bottomRight)
        description: |
          The gradient applied to the outer ring of the knob.
      innerKnobGradient:
        type: Gradient
        default: |
          LinearGradient(colors: [Colors.grey, Colors.black], begin: Alignment.topLeft, end: Alignment.bottomRight)
        description: |
          The gradient applied to the inner knob.
      sensitivity:
        type: double
        default: 0.5
        description: |
          Controls how sensitive the knob is to user input during drag gestures. Higher values make the knob more sensitive.
      knobLabel:
        type: Widget
        default: null
        description: |
          An optional widget that can be placed beneath the knob. Typically used to display a label, such as "Volume" or "Brightness."

## How It Works:
  Description: |
    The `FlutterOKnob` widget works by listening to drag gestures (`onPanUpdate`). When a user drags the knob, the value of the knob changes based on the drag movement. The updated value is clamped between `minValue` and `maxValue`, ensuring it stays within the allowed range. The value change is reflected visually by updating the `ValueNotifier` which triggers the widget to rebuild and display the new value.

    The widget also uses custom painting (`FlutterKnobPainter`) to render the knob's outer ring, inner knob, and value marker. This allows the widget to provide a smooth, customizable appearance while maintaining high performance.

## Customization Options:
  description: |
    The `FlutterOKnob` widget provides several options to customize its appearance and behavior. These options allow you to tailor the widget to fit your app’s design and functional needs.

  options:
    outerRingGradient:
      description: |
        You can customize the outer ring's gradient to match your app's theme.
      example: |
        outerRingGradient: LinearGradient(
          colors: [Colors.blue, Colors.cyan],
        )
    innerKnobGradient:
      description: |
        The inner knob's gradient can also be customized to fit your design.
      example: |
        innerKnobGradient: LinearGradient(
          colors: [Colors.orange, Colors.yellow],
        )
    markerColor:
      description: |
        Change the color of the marker that indicates the current value on the knob.
      example: |
        markerColor: Colors.red
    sensitivity:
      description: |
        Adjust the knob's sensitivity to user gestures.
      example: |
        sensitivity: 0.8
    knobLabel:
      description: |
        Add a custom widget as the label below the knob. This could be useful for showing a label like "Volume" or any other text.
      example: |
        knobLabel: Text(
          'Volume',
          style: TextStyle(color: Colors.white, fontSize: 16),
        )

## Notes:
  - Ensure that the initial value (`value`) is within the range defined by `minValue` and `maxValue` to avoid unexpected behavior.
  - For better UI consistency, customize the gradients, sensitivity, and marker color to match the design of your app.
  - The widget is responsive and adapts to different screen resolutions.

## Contribution:
  description: |
    If you'd like to contribute or report issues, feel free to open a pull request or an issue on the repository. Contributions such as bug fixes, performance improvements, and feature requests are always welcome.

## License:
  license: MIT
  description: |
    This project is licensed under the MIT License. See the LICENSE file for details.
