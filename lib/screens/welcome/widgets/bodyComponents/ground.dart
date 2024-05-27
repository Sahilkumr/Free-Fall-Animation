import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';

class Ground extends BodyComponent {
  final Vector2 gameSize;
  Ground(this.gameSize);

  @override
  Body createBody() {
    final shape = EdgeShape()
      ..set(
        Vector2(0, gameSize.y),
        Vector2(gameSize.x, gameSize.y),
      );
    final fixtureDef = FixtureDef(
      shape,
      friction: 1,
      restitution: 0,
    );
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(0, 0),
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void renderEdge(Canvas canvas, Offset p1, Offset p2) {
    final paint = Paint()..color = const Color(0xFFFCE469);
    canvas.drawLine(
        Offset(0, gameSize.y), Offset(gameSize.x, gameSize.y), paint);
  }
}
