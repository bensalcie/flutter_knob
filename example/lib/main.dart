import 'package:example/widgets/app_textview_medium.dart';
import 'package:flutter/material.dart';
import 'package:flutter_knob/flutter_knob.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Knob Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Knob Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Single Knob.
              const AppTextViewMedium(
                  weight: FontWeight.w900,
                  text: 'Knob Example Configuration',
                  textAlign: TextAlign.start),

              FlutterKnob(
                size: 200,
                value: 0,
                maxValue: 360,
                sensitivity: 0.2,
                onChanged: (brighness) {
                  debugPrint(
                      "Flutter Knob Changed Value : ==>  Brightness $brighness");
                },
                knobLabel: const AppTextViewMedium(
                    text: 'Brightness (0-100)', textAlign: TextAlign.center),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: FlutterKnob(
                      value: 40,
                      minValue: 0,
                      maxValue: 100,
                      onChanged: (newValue) {
                        debugPrint("Bass: $newValue");
                      },
                      knobLabel: const AppTextViewMedium(
                          text: 'Bass', textAlign: TextAlign.center),
                      markerColor: Colors.lightBlueAccent,
                      outerRingGradient: const LinearGradient(
                        colors: [Colors.lightBlue, Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      innerKnobGradient: const LinearGradient(
                        colors: [Colors.white, Colors.black],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlutterKnob(
                      value: 72,
                      minValue: 60,
                      maxValue: 90,
                      onChanged: (newValue) {
                        debugPrint("Temperature: $newValue°F");
                      },
                      knobLabel: const AppTextViewMedium(
                          text: 'Temperature', textAlign: TextAlign.center),
                      markerColor: Colors.red,
                      outerRingGradient: const LinearGradient(
                        colors: [Colors.red, Colors.yellow],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      innerKnobGradient: const LinearGradient(
                        colors: [Colors.white, Colors.grey],
                        begin: Alignment.center,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  )
                ],
              ),

              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: FlutterKnob(
                        value: 30,
                        minValue: 0,
                        maxValue: 100,
                        onChanged: (newValue) {
                          debugPrint("Volume set to $newValue");
                        },
                        knobLabel: const AppTextViewMedium(
                            text: 'Volume', textAlign: TextAlign.center),
                        markerColor: Colors.orangeAccent,
                        outerRingGradient: const LinearGradient(
                          colors: [Colors.orange, Colors.red],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        innerKnobGradient: const LinearGradient(
                          colors: [Colors.black, Colors.grey],
                          begin: Alignment.center,
                          end: Alignment.bottomLeft,
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: FlutterKnob(
                        value: 75,
                        minValue: 0,
                        maxValue: 100,
                        onChanged: (newValue) {
                          debugPrint("Weapon Intensity: $newValue%");
                        },
                        knobLabel: const AppTextViewMedium(
                            text: 'Game Controller',
                            textAlign: TextAlign.center),
                        markerColor: Colors.green,
                        outerRingGradient: const LinearGradient(
                          colors: [Colors.green, Colors.lightGreen],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        innerKnobGradient: const LinearGradient(
                          colors: [Colors.black, Colors.lightGreen],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      )),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: FlutterKnob(
                      value: 35,
                      minValue: 0,
                      maxValue: 100,
                      onChanged: (newValue) {
                        debugPrint("Custom Dark Knob: $newValue");
                      },
                      knobLabel: const AppTextViewMedium(
                          text: 'Dark Mode', textAlign: TextAlign.center),
                      markerColor: Colors.blueGrey,
                      outerRingGradient: const LinearGradient(
                        colors: [Colors.grey, Colors.black],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      innerKnobGradient: const LinearGradient(
                        colors: [Colors.black54, Colors.black87],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlutterKnob(
                      value: 50,
                      minValue: 0,
                      maxValue: 100,
                      knobLabel: const AppTextViewMedium(
                          text: 'Volume', textAlign: TextAlign.center),
                      onChanged: (newValue) {
                        debugPrint("Knob value: $newValue");
                      },
                      outerRingGradient: const LinearGradient(
                        colors: [Colors.blue, Colors.cyan],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      innerKnobGradient: const LinearGradient(
                        colors: [Colors.black, Colors.grey],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      markerColor: Colors.redAccent,
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: FlutterKnob(
                      value: 55,
                      minValue: 0,
                      maxValue: 120,
                      onChanged: (newValue) {
                        debugPrint("Speed: $newValue mph");
                      },
                      knobLabel: const AppTextViewMedium(
                          text: 'Speed', textAlign: TextAlign.center),
                      markerColor: Colors.red,
                      outerRingGradient: const LinearGradient(
                        colors: [Colors.grey, Colors.black],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      innerKnobGradient: const LinearGradient(
                        colors: [Colors.white, Colors.grey],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: FlutterKnob(
                        value: 50,
                        minValue: 0,
                        maxValue: 100,
                        onChanged: (newValue) {
                          debugPrint("Brightness: $newValue%");
                        },
                        knobLabel: const AppTextViewMedium(
                            text: 'Brightness', textAlign: TextAlign.center),
                        markerColor: Colors.yellow,
                        outerRingGradient: const LinearGradient(
                          colors: [Colors.yellow, Colors.amber],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        innerKnobGradient: const LinearGradient(
                          colors: [Colors.black, Colors.grey],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
