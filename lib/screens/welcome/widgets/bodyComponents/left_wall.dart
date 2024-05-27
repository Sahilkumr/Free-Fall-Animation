import 'dart:ui';

import 'package:flame_forge2d/flame_forge2d.dart';

class LeftWall extends BodyComponent {
  final Vector2 gameSize;
  LeftWall(this.gameSize);

  @override
  Body createBody() {
    final shape = EdgeShape()
      ..set(
        Vector2(0, 0),
        Vector2(-1, gameSize.y),
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
    canvas.drawLine(const Offset(0, 0), Offset(-1, gameSize.y), paint);
  }
}
