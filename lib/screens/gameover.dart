import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  const GameOver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map decisionMaking = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      backgroundColor: Colors.amber[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          decisionMaking['decision'] == 'win' ? const Text('You won') : const Text('Game Over'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [IconButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/start'),
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
              icon: const Icon(Icons.restart_alt),
            ),
            ],
          ),
        ]),
      ),
    );
  }
}
