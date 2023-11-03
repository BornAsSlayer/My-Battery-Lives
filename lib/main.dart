import 'package:flutter/material.dart';
import 'package:my_battery_lives/widgets/Battery_Percentage_Text.dart';
import 'package:my_battery_lives/widgets/battery_is_charged_as_per_your_requirement.dart';
import 'package:my_battery_lives/widgets/battery_status_text.dart';

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
  String labelText = 'enable 85 percentage battery ?';

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
            const TurnOnSwitch(),
            const BatteryPercentageText(),
            const BatteryStatusText(),
            const BatteryIsChargedAsPerYourRequirement(),
          ],
        )
      ),
    );
  }
}

class TurnOnSwitch extends StatefulWidget {
  const TurnOnSwitch({super.key});

  @override
  State<TurnOnSwitch> createState() => _TurnOnSwitchState();
}

class _TurnOnSwitchState extends State<TurnOnSwitch> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: light,
      onChanged: (bool value){
        setState(() {
          light = value;
        });
    });
  }
}
