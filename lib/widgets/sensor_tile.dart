import 'package:flutter/material.dart';

class SensorTile extends StatelessWidget {
  final String title;
  final String value;

  const SensorTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title, style: TextStyle(fontSize: 18)), Text(value, style: TextStyle(fontSize: 18))],
      ),
    ),
  );
}