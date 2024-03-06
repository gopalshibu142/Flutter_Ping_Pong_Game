//player file
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import './game.dart';

class Player extends PositionComponent
    with DragCallbacks, HasGameReference<MyGame>, KeyboardHandler {
  Player({
    required super.position,
    required super.size,
    required this.id,
    required this.life,
  }) : super(anchor: Anchor.center, children: [RectangleHitbox()]);
  final _paint = Paint()
    ..color = const Color(0xff1e6091)
    ..style = PaintingStyle.fill;
    
  final int id;
  int life;

  @override
  void update(double dt) {
    super.update(dt);

    final keysPressed = HardwareKeyboard.instance.logicalKeysPressed;
    if (id==1?keysPressed.contains(LogicalKeyboardKey.arrowLeft) :
        keysPressed.contains(LogicalKeyboardKey.keyA)) {
      position.x =
          (position.x - (dt * 500)).clamp(width / 2, game.width - width / 2);
    } else if (id==1?keysPressed.contains(LogicalKeyboardKey.arrowRight) :
        keysPressed.contains(LogicalKeyboardKey.keyD)) {
      position.x =
          (position.x + (dt * 500)).clamp(width / 2, game.width - width / 2);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size.toSize(),
        const Radius.circular(30),
      ),
      _paint,
    );
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (isRemoved) return;
    super.onDragUpdate(event);
    position.x = (position.x + event.localDelta.x)
        .clamp(width / 2, game.width - width / 2);
  }
}
