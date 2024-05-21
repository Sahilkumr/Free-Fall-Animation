import 'dart:async' as a;
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helm_demo/screens/welcome/cubit/mid_tag_line_cubit.dart';
import 'package:logger/logger.dart';

Logger log = Logger();

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
  }) : super();

  @override
  Color backgroundColor() {
    return const Color(0xFFFCE469);
  }

  late List<Container> containers;
  ValueNotifier<bool> isBuild = ValueNotifier(false);

  @override
  a.FutureOr<void> onLoad() async {
    await super.onLoad();

    containers = [
      Container(
        conPosition: Vector2(50, -chipDropPoint),
        image: 'intro_tag_1.png',
        iWidth: 100,
        vertices: [
          Vector2(-50, -26), // top left
          Vector2(50, -26), // top right
          Vector2(50, 26), // Bottom right
          Vector2(-50, 26), // Bottom left
        ],
        scHeight: scHeight,
        isBuild: isBuild,
      ),
      Container(
        conPosition: Vector2(170, -chipDropPoint),
        image: 'intro_tag_2.png',
        iWidth: 140,
        vertices: [
          Vector2(-66, -25), // top left
          Vector2(-66, 25), // Bottom left
          Vector2(66, -25), // top right
          Vector2(66, 25), // Bottom right
        ],
        scHeight: scHeight,
        isBuild: isBuild,
      ),
      Container(
        conPosition: Vector2(50, -chipDropPoint),
        image: 'intro_tag_3.png',
        iWidth: 110,
        vertices: [
          Vector2(-56, -25), // top left
          Vector2(56, -25), // top right
          Vector2(56, 25), // Bottom right
          Vector2(-56, 25), // Bottom left
        ],
        scHeight: scHeight,
        isBuild: isBuild,
      ),
      Container(
        conPosition: Vector2(180, -chipDropPoint),
        image: 'intro_tag_2.png',
        iWidth: 140,
        vertices: [
          Vector2(-68, -26), // top left
          Vector2(65, -24), // top right
          Vector2(65, 26), // Bottom right
          Vector2(-68, 26), // Bottom left
        ],
        scHeight: scHeight,
        isBuild: isBuild,
      ),
      Container(
        conPosition: Vector2(240, -chipDropPoint),
        image: 'intro_tag_2.png',
        iWidth: 140,
        vertices: [
          Vector2(-60, -25), // top left
          Vector2(-60, 25), // Bottom left
          Vector2(70, -25), // top right
          Vector2(70, 25), // Bottom right
        ],
        scHeight: scHeight,
        isBuild: isBuild,
      ),
    ];

    int currentContainerIndex = 0;

    Vector2 gameSize = Vector2(scWidth, scHeight);

    add(Ground(gameSize));
    add(LeftWall(gameSize));
    add(RightWall(gameSize));

    a.Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) async {
        if (kDebugMode) {
          print('currentIndex: $currentContainerIndex');
        }

        await add(containers[currentContainerIndex]);
        currentContainerIndex++;

        if (currentContainerIndex > 4) {
          timer.cancel();
        }
      },
    );
  }

  @override
  void update(double dt) async {
    super.update(dt);
    try {
      if (isBuild.value) {
        for (var e in containers) {
          try {
            if (e.body.position.y > scHeight * 0.70 && e.isBuild!.value) {
              updateBody(e);
              continue;
            }
          } catch (ex) {
            log.i('Exception occurred for ${e.image}: $ex');
          }
        }

        if (containers[containers.length - 1].body.position.y +
                containers[4].iWidth / 2 >
            (scHeight * 0.70)) {
          animCubit.animationEnded();
        }
      }
    } catch (ex) {
      log.d(' Outer Exception: $ex');
    }
  }

  void updateBody(Container con) {
    con.body.setType(BodyType.dynamic);
    con.body.gravityOverride = Vector2(0, 1500);
    con.body.fixtures.first.friction = 1;
    con.body.fixtures.first.restitution = 0;
  }
}

class Container extends BodyComponent {
  final Vector2 conPosition;
  final String image;
  final double iWidth;
  final List<Vector2> vertices;
  final double? scHeight;
  final ValueNotifier? isBuild;

  Container({
    required this.conPosition,
    required this.image,
    required this.iWidth,
    required this.vertices,
    this.scHeight,
    this.isBuild,
  });

  double cusGravity = 5;
  Vector2 velocity = Vector2(0, 20);

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
      density: 1,
      restitution: 0,
    );
    final bodyDef = BodyDef(
      position: conPosition,
      type: BodyType.static,
    );
    var body = world.createBody(bodyDef)..createFixture(fixtureDef);
    isBuild?.value = true;

    return body;
  }

  @override
  void update(double dt) {
    super.update(dt);

    velocity.y += cusGravity;

    body.position.y += velocity.y * dt;

    if (body.position.y > (scHeight! * 0.70)) {
      Future.delayed(const Duration(microseconds: 200), () {
        velocity.y = 0;
        cusGravity = 0;
      });
    }
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
