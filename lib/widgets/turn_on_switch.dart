import 'package:flutter/material.dart';

class TurnOnSwitchAndSlider extends StatefulWidget {
  const TurnOnSwitchAndSlider({super.key});

  @override
  State<TurnOnSwitchAndSlider> createState() => _TurnOnSwitchAndSliderState();
}

class _TurnOnSwitchAndSliderState extends State<TurnOnSwitchAndSlider> {
  bool light = true;
  double currValueForSlider = 85;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Switch(
          value: light,
          onChanged: (bool value){
            setState(() {
              light = value;
            });
          }
        ),
        Slider(
          value: currValueForSlider,
          max: 100,
          divisions: 20,
          label: currValueForSlider.round().toString(),
          onChanged: (double value) {
            setState(() {
              currValueForSlider = value;
            });
          }
        )
      ],
    );
  }
}