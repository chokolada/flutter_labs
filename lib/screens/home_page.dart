import 'package:flutter/material.dart';
import '../widgets/sensor_tile.dart';
import '../widgets/header_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: HeaderBar(title: "Smart Air Monitor", onProfileTap: () => Navigator.pushNamed(context, '/profile')),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SensorTile(title: "CO₂", value: "720 ppm"),
          SensorTile(title: "Температура", value: "23°C"),
          SensorTile(title: "Вологість", value: "58%"),
        ],
      ),
    ),
  );
}
