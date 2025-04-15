// lib/screens/profile_page.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isAutoMode = true;
  final tempController = TextEditingController(text: '23');
  final humController = TextEditingController(text: '58');
  final co2Controller = TextEditingController(text: '720');
  String userEmail = '';
  String userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('email') ?? '';
      userName = prefs.getString('name') ?? '';
      tempController.text = prefs.getString('temp') ?? '23';
      humController.text = prefs.getString('hum') ?? '58';
      co2Controller.text = prefs.getString('co2') ?? '720';
      isAutoMode = prefs.getBool('autoMode') ?? true;
    });
  }

  Future<void> _saveManualValues() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('temp', tempController.text);
    await prefs.setString('hum', humController.text);
    await prefs.setString('co2', co2Controller.text);
  }

  Future<void> _saveFieldsIfAutoMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('autoMode', isAutoMode);
    if (isAutoMode) {
      await prefs.setString('temp', tempController.text);
      await prefs.setString('hum', humController.text);
      await prefs.setString('co2', co2Controller.text);
    }
  }

  void _logout() {
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Профіль"),
          Text(userEmail, style: TextStyle(fontSize: 12)),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: _logout,
          tooltip: 'Вийти',
        )
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ім’я: $userName", style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          Text("Режим вентиляції:", style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          SwitchListTile(
            title: Text(isAutoMode ? "Автоматичний" : "Ручний"),
            value: isAutoMode,
            onChanged: (value) {
              setState(() => isAutoMode = value);
              _saveFieldsIfAutoMode();
            },
          ),
          SizedBox(height: 20),
          _buildInputField("Температура (°C)", tempController),
          SizedBox(height: 10),
          _buildInputField("Вологість (%)", humController),
          SizedBox(height: 10),
          _buildInputField("CO₂ (ppm)", co2Controller),
          if (!isAutoMode) ...[
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await _saveManualValues();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Дані збережено!")),
                  );
                },
                child: Text("Зберегти зміни"),
              ),
            )
          ]
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
