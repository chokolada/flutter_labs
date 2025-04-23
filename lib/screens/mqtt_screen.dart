import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../services/mqtt_service.dart';

class MqttScreen extends StatefulWidget {
  @override
  _MqttScreenState createState() => _MqttScreenState();
}

class _MqttScreenState extends State<MqttScreen> {
  final MqttService _mqttService = MqttService();
  String temperature = '---';
  bool isConnected = true;
  late Stream<ConnectivityResult> connectivityStream;

  @override
  void initState() {
    super.initState();
    _checkInitialConnectivity();
    _setupConnectivityListener();
    _mqttService.onMessageReceived = (message) {
      setState(() => temperature = message);
    };
    _mqttService.connect();
  }

  Future<void> _checkInitialConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      isConnected = connectivityResult != ConnectivityResult.none;
    });
    if (!isConnected) {
      _showNoInternetDialog();
    }
  }

  void _setupConnectivityListener() {
    connectivityStream = Connectivity().onConnectivityChanged;
    connectivityStream.listen((ConnectivityResult result) {
      setState(() {
        isConnected = result != ConnectivityResult.none;
      });
      if (!isConnected) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Втрачено підключення до Інтернету")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Підключення до Інтернету відновлено")),
        );
      }
    });
  }

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Немає підключення до Інтернету'),
        content: Text('Деякий функціонал може бути обмежений.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mqttService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MQTT Temperature')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isConnected ? 'Підключено до Інтернету' : 'Немає Інтернету',
              style: TextStyle(color: isConnected ? Colors.green : Colors.red),
            ),
            SizedBox(height: 20),
            Text('Temperature: $temperature °C', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
