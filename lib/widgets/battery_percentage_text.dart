import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryPercentageText extends StatefulWidget {
  const BatteryPercentageText({super.key});

  @override
  State<BatteryPercentageText> createState() => _BatteryPercentageTextState();
}

class _BatteryPercentageTextState extends State<BatteryPercentageText> {
  String batteryPercentage = 'battery percentage comes here...';

  final Battery _battery = Battery();
  late Timer timer;

  Future<void> showBatteryPercentage() async{
    final batteryLevel = await _battery.batteryLevel;
    setState(() {
      batteryPercentage = 'Battery now:$batteryLevel';
    });
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      showBatteryPercentage();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(batteryPercentage,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          color: Colors.grey,
          fontFamily: 'SomeTypeMono',
        ),
        )
      ],
    );
  }
}