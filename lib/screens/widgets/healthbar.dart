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

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.10,
          width: MediaQuery.of(context).size.width,
          color: Colors.red,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.10,
          width: MediaQuery.of(context).size.width * player.playerHealth / 100,
          color: Colors.green,
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

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.10,
          width: MediaQuery.of(context).size.width,
          color: Colors.red,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.10,
          width: MediaQuery.of(context).size.width * dealer.dealerHealth / 100,
          color: Colors.green,
        ),
      ],
    );
  }
}
