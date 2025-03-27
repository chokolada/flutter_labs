import 'package:flutter/material.dart';
import '../widgets/movable_box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interactive Field')),
      body: const Center(
        child: MovableBox(),
      ),
    );
  }
}
