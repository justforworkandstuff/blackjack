import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  const GameOver({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      body: const Center(
        child: Text('Game Over'),
        ),
    );
  }
}