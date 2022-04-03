import 'package:blackjackk/screens/gameover.dart';
import 'package:blackjackk/screens/homepage.dart';
import 'package:blackjackk/screens/startscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/start': (context) => const StartScreen(),
        '/home': (context) => const HomePage(),
        '/gameover': (context) => const GameOver(),
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const StartScreen(),
    );
  }
}
