import 'package:flutter/material.dart';
import 'package:my_battery_lives/widgets/Battery_Percentage_Text.dart';
import 'package:my_battery_lives/widgets/battery_is_charged_as_per_your_requirement.dart';
import 'package:my_battery_lives/widgets/turn_on_switch.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      useMaterial3: true,
    ),
    home: const Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String labelText = 'enable overcharge notification?';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Warning',
        style: TextStyle(
          fontFamily: 'SomeTypemono',
        ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 180),
            Text(labelText,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.grey,
                fontFamily: 'SometypeMono',
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const TurnOnSwitchAndSlider(),
            const BatteryPercentageText(),
            const BatteryIsChargedAsPerYourRequirement(),
          ],
        )
      ),
    );
  }
}