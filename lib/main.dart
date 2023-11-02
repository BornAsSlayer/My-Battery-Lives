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
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
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