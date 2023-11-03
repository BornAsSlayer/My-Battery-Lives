import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BatteryIsChargedAsPerYourRequirement extends StatefulWidget {
  const BatteryIsChargedAsPerYourRequirement({super.key});

  @override
  State<BatteryIsChargedAsPerYourRequirement> createState() => _BatteryIsChargedAsPerYourRequirementState();
}

class _BatteryIsChargedAsPerYourRequirementState extends State<BatteryIsChargedAsPerYourRequirement> {
  String isChargedOrNot = "";
  String batteryPercentage = "";
  String setBatteryPercentage = "30";

  final Battery _battery = Battery();
  late Timer timer;
  BatteryState? batteryState;
  StreamSubscription <BatteryState>? batteryStateSubscription;


  Future<void> showBatteryPercentage() async{
    final batteryLevel = await _battery.batteryLevel;
    setState(() {
      batteryPercentage = '$batteryLevel';
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
    _battery.batteryState.then(updateBatteryState);
    batteryStateSubscription = _battery.onBatteryStateChanged.listen(updateBatteryState);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int? intBatteryPercentage = int.tryParse(batteryPercentage); 
      int? intSetBatteryPercentage = int.tryParse(setBatteryPercentage);

      Future<void> getBatteryPercentage() async{
        try {
          await showBatteryPercentage();
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }

      getBatteryPercentage().then((_) => {
        if('$batteryState' == 'BatteryState.discharging'){
          isChargedOrNot = 'Connect the charger'
        }else if(intBatteryPercentage == 100){
          isChargedOrNot = 'Battery is Charged to full'
        }else if('$batteryState' == 'BatteryState.charging' && intBatteryPercentage! <= intSetBatteryPercentage!){
          isChargedOrNot = 'Battery is now over $setBatteryPercentage, please remove the charger!'
        }else{
          isChargedOrNot = 'Battery is now charging and is at $batteryPercentage%'
        }
      });
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