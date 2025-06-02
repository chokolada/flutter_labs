// lib/screens/register_page.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../models/user_model.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> _register() async {
    if (!formKey.currentState!.validate()) return;

    final prefs = await SharedPreferences.getInstance();
    final user = UserModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    await prefs.setString('email', user.email);
    await prefs.setString('password', user.password);
    await prefs.setString('name', nameController.text.trim());

    Navigator.pushReplacementNamed(context, '/login');
  }

  String? _validateEmail(String? value) =>
      value != null && value.contains('@') ? null : 'Некоректна пошта';

  String? _validateName(String? value) =>
      value != null && !RegExp(r'[0-9]').hasMatch(value) ? null : 'Ім’я не повинно містити цифри';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Реєстрація")),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextField(label: "Ім’я", controller: nameController, validator: _validateName),
            SizedBox(height: 16),
            CustomTextField(label: "Email", controller: emailController, validator: _validateEmail),
            SizedBox(height: 16),
            CustomTextField(label: "Пароль", controller: passwordController, isPassword: true),
            SizedBox(height: 20),
            PrimaryButton(label: "Зареєструватися", onPressed: _register),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Вже маєш акаунт? Увійти"),
            )
          ],
        ),
      ),
    ),
  );
}
