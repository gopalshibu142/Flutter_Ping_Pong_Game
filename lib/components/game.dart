import 'dart:async';
import 'dart:math' as math;
import 'package:firstgame/components/ball.dart';
import 'package:firstgame/global.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'player.dart';

//Lets create a simple pong game both android and web compatable
class MyGame extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapDetector {
  late Player player1;
  late Player player2;

  //BuildContext context;
  MyGame()
      : super(
            camera: CameraComponent.withFixedResolution(
                width: gameWidth, height: gameHeight)) {
                   player1 = Player(
      id: 1,
      life: 10,
      position: Vector2(width / 2, height * 0.95),
      size: Vector2(gameWidth * 0.3, gameHeight * 0.05),
    );
    player2 = Player(
      life: 10,
      id: 2,
      position: Vector2(width / 2, height * 0.05),
      size: Vector2(gameWidth * 0.3, gameHeight * 0.05),
    );
                }

  @override
  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    camera.viewfinder.anchor = Anchor.topLeft;
    world.add(PlayArea());
    startGame();
  }

  void startGame() {
    world.removeAll(world.children.query<Ball>());
    world.removeAll(world.children.query<Player>());

    world.add(player1);

    world.add(player2);
    double x = rand.nextDouble() * 2 - 1;
    world.add(Ball(
      velocity: Vector2(200, 1000),
      position: Vector2(width / 2, height / 2),
      radius: 20,
      difficultyModifier: 10,
    ));
  }
}

class PlayArea extends RectangleComponent with HasGameReference<MyGame> {
  PlayArea() : super(children: [RectangleHitbox()]);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}
