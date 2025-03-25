import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class RegisterPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _register(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', emailController.text);
    await prefs.setString('password', passwordController.text);
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Реєстрація")),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          CustomTextField(label: "Email", controller: emailController),
          SizedBox(height: 16),
          CustomTextField(label: "Пароль", controller: passwordController, isPassword: true),
          SizedBox(height: 20),
          PrimaryButton(label: "Зареєструватися", onPressed: () => _register(context)),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Вже маєш акаунт? Увійти"),
          )
        ],
      ),
    ),
  );
}