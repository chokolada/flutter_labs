// lib/screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/sensor_tile.dart';
import '../widgets/header_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String co2 = '720';
  String temp = '23';
  String hum = '58';

  @override
  void initState() {
    super.initState();
    _loadSensorValues();
  }

  Future<void> _loadSensorValues() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      co2 = prefs.getString('co2') ?? '720';
      temp = prefs.getString('temp') ?? '23';
      hum = prefs.getString('hum') ?? '58';
    });
  }

  void _navigateToProfile() {
    Navigator.pushNamed(context, '/profile').then((_) => _loadSensorValues());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: HeaderBar(title: "Smart Air Monitor", onProfileTap: _navigateToProfile),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SensorTile(title: "CO₂", value: "$co2 ppm"),
          SensorTile(title: "Температура", value: "$temp°C"),
          SensorTile(title: "Вологість", value: "$hum%"),
        ],
      ),
    ),
  );
}
