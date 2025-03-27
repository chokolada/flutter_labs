import 'package:flutter/material.dart';

class MovableBox extends StatefulWidget {
  const MovableBox({super.key});

  @override
  _MovableBoxState createState() => _MovableBoxState();
}

class _MovableBoxState extends State<MovableBox> {
  double _x = 0;
  double _y = 0;
  final double _step = 20.0;
  final TextEditingController _controller = TextEditingController();

  void _move(String direction) {
    setState(() {
      switch (direction.toLowerCase()) {
        case 'up':
          _y -= _step;
          break;
        case 'down':
          _y += _step;
          break;
        case 'left':
          _x -= _step;
          break;
        case 'right':
          _x += _step;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              width: 200,
              height: 200,
              color: Colors.grey[300],
              child: Stack(
                children: [
                  Positioned(
                    left: _x,
                    top: _y,
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Enter direction (up, down, left, right)',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (value) {
              _move(value);
              _controller.clear();
            },
          ),
        ),
      ],
    );
  }
}
