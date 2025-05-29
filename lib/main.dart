import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';
import 'screens/home_page.dart';
import 'screens/profile_page.dart';

void main() => runApp(SmartAirMonitorApp());

class SmartAirMonitorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Air Monitor',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      initialRoute: '/login',
      routes: {
        '/login': (_) => LoginPage(),
        '/register': (_) => RegisterPage(),
        '/home': (_) => HomePage(),
        '/profile': (_) => ProfilePage(),
      },
    );
  }
}