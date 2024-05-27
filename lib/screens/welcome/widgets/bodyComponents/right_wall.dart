import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';

class RightWall extends BodyComponent {
  final Vector2 gameSize;
  RightWall(this.gameSize);

  @override
  Body createBody() {
    final shape = EdgeShape()
      ..set(
        Vector2(gameSize.x, 0),
        Vector2(gameSize.x, gameSize.y),
      );
    final fixtureDef = FixtureDef(
      shape,
      friction: 1,
    );
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2.zero(),
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void renderEdge(Canvas canvas, Offset p1, Offset p2) {
    final paint = Paint()..color = const Color(0xFFFCE469);
    canvas.drawLine(
        Offset(gameSize.x, 0), Offset(gameSize.x, gameSize.y), paint);
  }
}
