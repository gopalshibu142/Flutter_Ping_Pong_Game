import 'dart:ui';

import 'package:firstgame/components/game.dart';
import 'package:firstgame/components/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';


class Ball extends CircleComponent
    with CollisionCallbacks, HasGameReference<MyGame> {
  Ball({
    required this.velocity,
    required super.position,
    required double radius,
    required this.difficultyModifier,
  }) : super(
            radius: radius,
            anchor: Anchor.center,
            paint: Paint()
              ..color = const Color(0xff1e6091)
              ..style = PaintingStyle.fill,
            children: [CircleHitbox()]);

  final Vector2 velocity;
  final double difficultyModifier;

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayArea) {
      if (intersectionPoints.first.y <= 0) {
        velocity.y = -velocity.y;
      } else if (intersectionPoints.first.x <= 0) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.x >= game.width) {
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y >= game.height) {
        velocity.y = -velocity.y;
        game.player1.life -= 1;
        // code to write point on the screen using paint


        if (game.player1.life <= 0) {
          game.player2.life = 10;
          game.player1.life = 10;
          game.startGame();
        }
      }
    } else if (other is Player) {
      velocity.y = -velocity.y;
      velocity.x = velocity.x +
          (position.x - other.position.x) / other.size.x * game.width * 0.3;
    // } else if (other is Brick) {
    //   if (position.y < other.position.y - other.size.y / 2) {
    //     velocity.y = -velocity.y;
    //   } else if (position.y > other.position.y + other.size.y / 2) {
    //     velocity.y = -velocity.y;
    //   } else if (position.x < other.position.x) {
    //     velocity.x = -velocity.x;
    //   } else if (position.x > other.position.x) {
    //     velocity.x = -velocity.x;
    //   }
    //   velocity.setFrom(velocity * difficultyModifier);
    }
  }
}