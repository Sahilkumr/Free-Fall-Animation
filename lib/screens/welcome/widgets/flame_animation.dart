import 'dart:async' as a;
import 'dart:ui';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class FlameAnimation extends Forge2DGame {
  final double scWidth;
  final double scHeight;

  late BackGround bgColor;

  FlameAnimation({
    required this.scWidth,
    required this.scHeight,
  }) : super(gravity: Vector2(0, 1000));

  @override
  Color backgroundColor() {
    return const Color(0xFFFCE469);
  }

  @override
  a.FutureOr<void> onLoad() async {
    await super.onLoad();

    // bgColor = BackGround()..size = Vector2.zero();
    // add(bgColor);

    List<Container> containers = [
      Container(
        conPosition: Vector2(160, 3),
        image: 'intro_tag_4.png',
        iWidth: 150,
        cRadii: 20,
      ),
      Container(
        conPosition: Vector2(300, 3),
        image: 'intro_tag_5.png',
        iWidth: 140,
        cRadii: 20,
      ),
      Container(
        conPosition: Vector2(50, 50),
        image: 'intro_tag_1.png',
        iWidth: 100,
        cRadii: 26,
      ),
      Container(
        conPosition: Vector2(310, 100),
        image: 'intro_tag_2.png',
        iWidth: 120,
        cRadii: 26,
      ),
      Container(
        conPosition: Vector2(50, 100),
        image: 'intro_tag_3.png',
        iWidth: 100,
        cRadii: 26,
      ),
    ];
    int currentContainerIndex = 0;

    Vector2 gameSize = Vector2(scWidth, scHeight);
    // print('GameSize Value : ${camera.viewport.size}');
    // print('gmaesize y : ${gameSize.y}');
    // print('gmaesize x : ${gameSize.x}');
    add(Ground(gameSize));
    add(LeftWall(gameSize));
    add(RightWall(gameSize));

    a.Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
        if (currentContainerIndex < containers.length) {
          if (containers[currentContainerIndex]
              .image
              .contains('intro_tag_4.png')) {
            containers[currentContainerIndex] = Container(
              conPosition: Vector2(70, 130),
              image: 'intro_tag_4.png',
              iWidth: 140,
              cRadii: 26,
            );
          } else if (containers[currentContainerIndex]
              .image
              .contains('intro_tag_5.png')) {
            containers[currentContainerIndex] = Container(
              conPosition: Vector2(190, 130),
              image: 'intro_tag_5.png',
              iWidth: 140,
              cRadii: 26,
            );
          }
          add(containers[currentContainerIndex]);
          print('image name: ${containers[currentContainerIndex].image}');
          currentContainerIndex++;
        } else {
          timer.cancel();
        }
      },
    );
  }
}

// class Container extends BodyComponent {
//   final Vector2 conPosition;
//   final String image;
//   final double iWidth;
//   final double cRadii;

//   Container({
//     required this.conPosition,
//     required this.image,
//     required this.iWidth,
//     required this.cRadii,
//   });
//   @override
//   Future<void> onLoad() async {
//     await super.onLoad();
//     renderBody = true;

//     add(
//       SpriteComponent(
//         sprite: await Sprite.load(image),
//         size: Vector2(iWidth, 50),
//         anchor: Anchor.center,
//       ),
//     );
//   }

//   @override
//   Body createBody() {
//     final shape = CircleShape()..radius = cRadii;
//     final fixtureDef = FixtureDef(
//       shape,
//       friction: 1,
//       density: 1,
//       restitution: 0,
//     );
//     final bodyDef = BodyDef(
//       position: conPosition,
//       type: BodyType.dynamic,
//     );

//     return world.createBody(bodyDef)..createFixture(fixtureDef);
//   }
// }

class Ground extends BodyComponent {
  final Vector2 gameSize;
  Ground(this.gameSize);

  @override
  Body createBody() {
    final shape = EdgeShape()
      ..set(
        Vector2(-5, gameSize.y - 5),
        Vector2(gameSize.x - 5, gameSize.y - 5),
      );
    final fixtureDef = FixtureDef(
      shape,
      friction: 0.1,
    );
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2.zero(),
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

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
      friction: 0.1,
    );
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2.zero(),
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

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
      friction: 0.1,
    );
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2.zero(),
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class BackGround extends PositionComponent {
  @override
  void render(Canvas canvas) {
    // super.render(canvas);
    canvas.drawColor(Colors.yellow, BlendMode.src);
  }
}


class PolygonContainer extends BodyComponent {
  final Vector2 conPosition;
  final String image;
  final double iWidth;
  final double iHeight; // New property for the height of the polygon
  final List<Vector2> vertices; // Vertices of the polygon

  PolygonContainer({
    required this.conPosition,
    required this.image,
    required this.iWidth,
    required this.iHeight,
  }) : vertices = [
         Vector2(0, 0),
         Vector2(iWidth, 0),
         Vector2(iWidth, iHeight), // Bottom right
         Vector2(0, iHeight),      // Bottom left
       ];

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = true;

    add(
      SpriteComponent(
        sprite: await Sprite.load(image),
        size: Vector2(iWidth, iHeight), // Update size to match polygon
        anchor: Anchor.center,
      ),
    );
  }

  @override
  Body createBody() {
    final shape = PolygonShape()..set(vertices);
    final fixtureDef = FixtureDef(
      shape,
      friction: 1,
      density: 1,
      restitution: 0,
    );
    final bodyDef = BodyDef(
      position: conPosition,
      type: BodyType.dynamic,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
