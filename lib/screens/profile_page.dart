
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isAutoMode = true;
  final tempController = TextEditingController(text: '23');
  final humController = TextEditingController(text: '58');
  final co2Controller = TextEditingController(text: '720');

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Профіль")),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Режим вентиляції:", style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          SwitchListTile(
            title: Text(isAutoMode ? "Автоматичний" : "Ручний"),
            value: isAutoMode,
            onChanged: (value) {
              setState(() => isAutoMode = value);
            },
          ),
          SizedBox(height: 20),
          _buildInputField("Температура (°C)", tempController),
          SizedBox(height: 10),
          _buildInputField("Вологість (%)", humController),
          SizedBox(height: 10),
          _buildInputField("CO₂ (ppm)", co2Controller),
        ],
      ),
    ),
  );

  Widget _buildInputField(String label, TextEditingController controller) => TextField(
    controller: controller,
    enabled: !isAutoMode,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    ),
  );
}