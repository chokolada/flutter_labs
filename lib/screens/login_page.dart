import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    emailController.text = prefs.getString('email') ?? '';
    passwordController.text = prefs.getString('password') ?? '';
  }

  void _login() => Navigator.pushReplacementNamed(context, '/home');

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Вхід")),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          CustomTextField(label: "Email", controller: emailController),
          SizedBox(height: 16),
          CustomTextField(label: "Пароль", controller: passwordController, isPassword: true),
          SizedBox(height: 20),
          PrimaryButton(label: "Увійти", onPressed: _login),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/register'),
            child: Text("Ще не має акаунту? Зареєструватися"),
          )
        ],
      ),
    ),
  );
}