import 'package:flutter/material.dart';

import 'pages/gamescreen.dart';

void main() {
  runApp(const GameApp());
}

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //rotate the app to landscape
      builder: (context, child) {
        return  RotatedBox(
          quarterTurns: MediaQuery.of(context).orientation == Orientation.landscape ? 1 : 0,
          child: GameScreen(),
        );
      },
    );
  }
}
