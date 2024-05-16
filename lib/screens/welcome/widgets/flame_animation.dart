import 'dart:async' as a;
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helm_demo/screens/welcome/cubit/mid_tag_line_cubit.dart';

class FlameAnimation extends Forge2DGame {
  final double scWidth;
  final double scHeight;
  final double chipDropPoint;
  final MidTagLineCubit animCubit;

  FlameAnimation({
    required this.scWidth,
    required this.scHeight,
    required this.chipDropPoint,
    required this.animCubit,
  }) : super(gravity: Vector2(0, 3000));

  @override
  Color backgroundColor() {
    return const Color(0xFFFCE469);
  }

  @override
  void update(double dt) async {
    super.update(dt);
    // await Future.delayed(
    //   const Duration(seconds: 0),
    //   () {
    if (containers[containers.length - 1].body.position.y +
            containers[4].iWidth / 2 >
        scHeight - 1) {
      animCubit.animationEnded();
    }
  }

  // );

  late List<Container> containers;

  @override
  a.FutureOr<void> onLoad() async {
    if (kDebugMode) {
      print('drop point height : $chipDropPoint');
    }
    await super.onLoad();

    containers = [
      Container(
        conPosition: Vector2(50, -chipDropPoint),
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
        conPosition: Vector2(170, -chipDropPoint),
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
        conPosition: Vector2(57, -chipDropPoint),
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
        conPosition: Vector2(150, -chipDropPoint),
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
        conPosition: Vector2(230, -chipDropPoint),
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

    add(Ground(gameSize));
    add(LeftWall(gameSize));
    add(RightWall(gameSize));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      a.Timer.periodic(
        const Duration(milliseconds: 1000),
        (timer) {
          if (kDebugMode) {
            print('currentIndex: $currentContainerIndex');
          }

          add(containers[currentContainerIndex]);
          currentContainerIndex++;

          if (currentContainerIndex > 4) {
            timer.cancel();
            // Future.delayed(
            //   const Duration(seconds: 6),
            //   () {
            //     animCubit.animationEnded();
            //   },
            // );
          }
        },
      );
    });
  }
}

class Container extends BodyComponent {
  final Vector2 conPosition;
  final String image;
  final double iWidth;
  final List<Vector2> vertices;

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
      bullet: false,
      linearVelocity: Vector2(0, 1000) * 5,
    );

    var body = world.createBody(bodyDef)
      ..createFixture(fixtureDef)
      ..applyForce(
        Vector2(0, 500),
      );
    return body;
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
