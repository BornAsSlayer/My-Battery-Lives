import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryStatusText extends StatefulWidget {
  const BatteryStatusText({super.key});

  @override
  State<BatteryStatusText> createState() => _BatteryStatusTextState();
}

class _BatteryStatusTextState extends State<BatteryStatusText> {
  final Battery battery = Battery();
  String batteryStatus = "battery status is shown here";

  BatteryState? batteryState;
  StreamSubscription <BatteryState>? batteryStateSubscription;

  void updateBatteryState(BatteryState state){
    if(batteryState == state) return;
    setState(() {
      batteryState = state;
    });
  }

  @override
  void initState() {
    super.initState();
    battery.batteryState.then(updateBatteryState);
    batteryStateSubscription = battery.onBatteryStateChanged.listen(updateBatteryState);
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$batteryState',style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          color: Colors.grey,
          fontFamily: 'SomeTypeMono',
        )
        )
      ],
    );
  }
}