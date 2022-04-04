import 'package:blackjackk/viewmodel/dealer.dart';
import 'package:blackjackk/viewmodel/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HealthBar extends StatelessWidget {
  const HealthBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<Player>(context);
    final sizeStuff = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          height: sizeStuff.height * 0.10,
          width: sizeStuff.width,
          color: Colors.red,
        ),
        AnimatedContainer(
          height: sizeStuff.height * 0.10,
          width: sizeStuff.width * player.playerHealth / 100,
          color: Colors.green,
          duration: const Duration(seconds: 1),
        ),
      ],
    );
  }
}

class HealthBarD extends StatelessWidget {
  const HealthBarD({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dealer = Provider.of<Dealer>(context);
    final sizeStuff = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          height: sizeStuff.height * 0.10,
          width: sizeStuff.width,
          color: Colors.red,
        ),
        AnimatedContainer(
          height: sizeStuff.height * 0.10,
          width: sizeStuff.width * dealer.dealerHealth / 100,
          color: Colors.green, 
          duration: const Duration(seconds: 1),
        ),
      ],
    );
  }
}
