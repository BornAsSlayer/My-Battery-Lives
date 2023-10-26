import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      useMaterial3: true,
    ),
    home: const Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

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
      body: const Center(
        child: Column(
          children: [
            SizedBox(height: 180),
            Text('enable 85 percentage battery ?',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Colors.grey,
              fontFamily: 'SometypeMono',
            ),
            ),
            TurnOnSwitch(),
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