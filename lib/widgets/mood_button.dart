import 'package:flutter/material.dart';

class MoodButton extends StatelessWidget {
  final String emoji;
  final VoidCallback onTap;

  const MoodButton({required this.emoji, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        emoji,
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
