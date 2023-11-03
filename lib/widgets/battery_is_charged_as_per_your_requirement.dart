import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryIsChargedAsPerYourRequirement extends StatefulWidget {
  const BatteryIsChargedAsPerYourRequirement({super.key});

  @override
  State<BatteryIsChargedAsPerYourRequirement> createState() => _BatteryIsChargedAsPerYourRequirementState();
}

class _BatteryIsChargedAsPerYourRequirementState extends State<BatteryIsChargedAsPerYourRequirement> {
  final Battery _battery = Battery();
  late Timer timer;
  int intBatteryLevel=0;
  String isChargedOrNot = '';
  int setBatteryPercentage = 85;
  
  BatteryState? batteryState;
  StreamSubscription <BatteryState>? batteryStateSubscription;

  Future<void> getBatteryLevel() async{
    final batteryLevel = await _battery.batteryLevel;
    setState(() {
      intBatteryLevel = batteryLevel;
    });
  }

  void updateBatteryState(BatteryState state){
    if(batteryState == state) return;
    setState(() {
      batteryState = state;
    });
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getBatteryLevel();
      _battery.batteryState.then(updateBatteryState);
      batteryStateSubscription = _battery.onBatteryStateChanged.listen(updateBatteryState);
  
      if('$batteryState' == 'BatteryState.discharging' && intBatteryLevel < 40){
          isChargedOrNot = 'Connect the charger';
        }else if(intBatteryLevel == 100){
          isChargedOrNot = 'Battery is Charged to full';
        }else if('$batteryState' == 'BatteryState.charging' && setBatteryPercentage <= intBatteryLevel){
          isChargedOrNot = 'Battery is now over $setBatteryPercentage, please remove the charger!';
        }else{
          isChargedOrNot = 'Battery is now charging and is at $intBatteryLevel%';
        }
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
        Text(isChargedOrNot,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          color: Colors.grey,
          fontFamily: 'SomeTypeMono',
        ),
        textAlign: TextAlign.center,
        )
      ],
    );
  }
}

// if('$batteryState' == 'BatteryState.discharging'){
//           isChargedOrNot = 'Connect the charger'
//         }else if(intBatteryPercentage == 100){
//           isChargedOrNot = 'Battery is Charged to full'
//         }else if('$batteryState' == 'BatteryState.charging' && intBatteryPercentage! <= intSetBatteryPercentage!){
//           isChargedOrNot = 'Battery is now over $setBatteryPercentage, please remove the charger!'
//         }else{
//           isChargedOrNot = 'Battery is now charging and is at $batteryPercentage%'
//         }