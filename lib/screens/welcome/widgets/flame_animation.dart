import 'dart:async' as a;
import 'dart:ui';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:helm_demo/screens/welcome/cubit/mid_tag_line_cubit.dart';

class FlameAnimation extends Forge2DGame {
  final double scWidth;
  final double scHeight;
  final MidTagLineCubit animCubit;

  FlameAnimation({
    required this.scWidth,
    required this.scHeight,
    required this.animCubit,
  }) : super(gravity: Vector2(0, 700));

  @override
  Color backgroundColor() {
    return const Color(0xFFFCE469);
  }

  @override
  a.FutureOr<void> onLoad() async {
    await super.onLoad();
    List<Container> containers = [
      Container(
        conPosition: Vector2(50, 10),
        image: 'intro_tag_1.png',
        iWidth: 100,
        vertices: [
          Vector2(-50, -25), // top left
          Vector2(50, -25), // top right
          Vector2(50, 25), // Bottom right
          Vector2(-50, 25), // Bottom left
        ],
      ),
      Container(
        conPosition: Vector2(170, 10),
        image: 'intro_tag_2.png',
        iWidth: 140,
        vertices: [
          Vector2(-60, -25), // top left
          Vector2(-60, 25), // Bottom left
          Vector2(65, -25), // top right
          Vector2(65, 25), // Bottom right
        ],
      ),
      Container(
        conPosition: Vector2(50, 10),
        image: 'intro_tag_3.png',
        iWidth: 110,
        vertices: [
          Vector2(-55, -25), // top left
          Vector2(55, -18), // top right
          Vector2(55, 25), // Bottom right
          Vector2(-55, 25), // Bottom left
        ],
      ),
      Container(
        conPosition: Vector2(150, 10),
        image: 'intro_tag_2.png',
        iWidth: 140,
        vertices: [
          Vector2(-60, -25), // top left
          Vector2(65, -25), // top right
          Vector2(65, 20), // Bottom right
          Vector2(-60, 25), // Bottom left
        ],
      ),
      Container(
        conPosition: Vector2(230, 10),
        image: 'intro_tag_2.png',
        iWidth: 140,
        vertices: [
          Vector2(-60, -25), // top left
          Vector2(-60, 25), // Bottom left
          Vector2(70, -25), // top right
          Vector2(70, 25), // Bottom right
        ],
      ),
    ];

    int currentContainerIndex = 0;

    Vector2 gameSize = Vector2(scWidth, scHeight);
    print('scHeight: $scHeight');
    // print('GameSize Value : ${camera.viewport.size}');
    print('gmaesize y : ${gameSize.y}');
    print('gmaesize x : ${gameSize.x}');
    add(Ground(gameSize));
    add(LeftWall(gameSize));
    add(RightWall(gameSize));

    a.Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        print('currentIndex: $currentContainerIndex');

        add(containers[currentContainerIndex]);
        // print('image name: ${containers[currentContainerIndex].image}');
        currentContainerIndex++;
        if (currentContainerIndex > 4) {
          timer.cancel();
          animCubit.animationEnded();
          print('con Position : ${containers[4].conPosition.y == scHeight}');
        }
      },
    );
  }
}

class Container extends BodyComponent {
  final Vector2 conPosition;
  final String image;
  final double iWidth;
  final List<Vector2> vertices; // Vertices of the polygon

  Container({
    required this.conPosition,
    required this.image,
    required this.iWidth,
    required this.vertices,
  });
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;

    add(
      SpriteComponent(
        sprite: await Sprite.load(image),
        size: Vector2(iWidth, 50),
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
      density: 0.1,
      restitution: 0,
    );
    final bodyDef = BodyDef(
      position: conPosition,
      type: BodyType.dynamic,
      bullet: true,
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

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
