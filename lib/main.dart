import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

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

  final Battery _battery = Battery();

  Future<void> showBatteryPercentage() async{

    final batteryLevel = await _battery.batteryLevel;

    setState(() {
      labelText = batteryLevel.toString();
    });

  }

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
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()=>{
        showBatteryPercentage(),
      }),
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