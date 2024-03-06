import 'package:firstgame/components/game.dart';
import 'package:firstgame/global.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

//Lets create a simple game with a player and some enemies
class GameScreen extends StatefulWidget {
   GameScreen({super.key}){}

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
  }
  
  MyGame game = MyGame( );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffa9d6e5),
              Color(0xfff2e8cf),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: FittedBox(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child:Stack(
                    children: [
                      GameWidget(game: game),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Player 1: ${game.player1.life}', style: TextStyle(fontSize: 30, color: Colors.black)),
                            Text('Player 2: ${game.player2.life}', style: TextStyle(fontSize: 30, color: Colors.black)),
                          ],
                        ),
                      
                      )],
                      
                  )
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
