## 0.0.5

### Overview:
FlutterOKnob now includes additional configuration options to give developers even more control over the knob's behavior and visual feedback. These enhancements provide better UX, fine-tuned interaction, and more intuitive number positioning.

### What's New:

1. maxRotationAngle  
   - Introduced a new parameter that defines the rotational range (in degrees) of the knob.  
   - This directly impacts how values are distributed between minValue and maxValue, allowing for more accurate mapping and greater customization of the knob's behavior.

2. Improved Sensitivity Handling  
   - The sensitivity parameter has been enhanced to offer a more realistic and smoother user interaction.  
   - Dragging the knob now feels more natural and responsive, resulting in better overall UX.

3. angleOffset Parameter Added  
   - A new angle offset parameter determines the starting angle for the knob's visual numbering and rotation arc.  
   - Developers can now control where the minimum and maximum values visually appear, offering improved alignment and thematic control for their UI designs.

### Additional Improvements:
- Optimized the painter to reflect the new rotational range and angle offset dynamically.
- Minor internal refactoring to improve maintainability and customization consistency.


## 0.0.4

## Overview:
  Description: |
    The FlutterKnob widget provides a customizable rotary knob that can be used for various controls, such as adjusting volume, brightness, or any other value within a specified range. This widget is interactive, supports various styling options, and provides smooth performance, making it suitable for a variety of applications.

## Features:
  - Interactive Control: Allows users to drag and adjust values in a specified range.
  - Customizable Appearance: Support for size, color, gradients, sensitivity, and more.
  - Value Tracking: Emits changes through the `onChanged` callback for external handling.
  - Optional Label: Allows display of a custom label beneath the knob for added context.
  - Smooth Performance: Optimized for smooth interaction and visual updates.

## Dependencies:
  - Flutter SDK (ensure that your project is configured to use Flutter 3.0 or above).
