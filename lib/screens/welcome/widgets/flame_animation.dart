import 'dart:async' as asyn;
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helm_demo/screens/welcome/cubit/mid_tag_line_cubit.dart';
import 'package:helm_demo/screens/welcome/widgets/bodyComponents/custom_chip_shape.dart';
import 'package:helm_demo/screens/welcome/widgets/bodyComponents/ground.dart';
import 'package:helm_demo/screens/welcome/widgets/bodyComponents/left_wall.dart';
import 'package:helm_demo/screens/welcome/widgets/bodyComponents/right_wall.dart';
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

  late List<CustomChipShape> customChipShapes;
  ValueNotifier<bool> isBuild = ValueNotifier(false);
  double tag1IWidth = 100;
  double tag2IWidth = 140;
  double tag3IWidth = 110;
  double tag4IWidth = 190;
  double tag5Width = 180;

  @override
  asyn.FutureOr<void> onLoad() async {
    await super.onLoad();

    customChipShapes = [
      CustomChipShape(
        conPosition: Vector2(50, -chipDropPoint),
        image: 'intro_tag_1.png',
        iWidth: tag1IWidth,
        scHeight: scHeight,
      ),
      CustomChipShape(
        conPosition: Vector2(170, -chipDropPoint),
        image: 'intro_tag_2.png',
        iWidth: tag2IWidth,
        scHeight: scHeight,
      ),
      CustomChipShape(
        conPosition: Vector2(53, -chipDropPoint),
        image: 'intro_tag_3.png',
        iWidth: tag3IWidth,
        scHeight: scHeight,
      ),
      CustomChipShape(
        conPosition: Vector2(188, -chipDropPoint),
        image: 'intro_tag_4.png',
        iWidth: tag4IWidth,
        scHeight: scHeight,
      ),
      CustomChipShape(
        conPosition: Vector2(240, -chipDropPoint),
        image: 'intro_tag_5.png',
        iWidth: tag5Width,
        scHeight: scHeight,
      ),
    ];

    int currentCustomChipShapeIndex = 0;

    Vector2 gameSize = Vector2(scWidth, scHeight);

    add(Ground(gameSize));
    add(LeftWall(gameSize));
    add(RightWall(gameSize));

    asyn.Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) async {
        if (kDebugMode) {
          print(
            'currentIndex: $currentCustomChipShapeIndex --> CurrentImage: ${customChipShapes[currentCustomChipShapeIndex].image.toString()}',
          );
        }
        await add(customChipShapes[currentCustomChipShapeIndex]);
        currentCustomChipShapeIndex++;

        if (currentCustomChipShapeIndex > 4) {
          timer.cancel();
        }
      },
    );
  }

  @override
  void update(double dt) async {
    super.update(dt);
    try {
      for (var e in customChipShapes) {
        try {
          if (e.isBodyInitialized && e.body.position.y > scHeight * 0.70) {
            _updateBody(e);
            continue;
          }
        } catch (ex) {
          log.i('Exception occurred for ${e.image}: $ex');
        }

        if (customChipShapes.isNotEmpty &&
            customChipShapes.last.isBodyInitialized &&
            customChipShapes.last.body.position.y +
                    customChipShapes.last.iWidth / 2 >
                (scHeight * 0.70)) {
          animCubit.animationEnded();
        }
      }
    } catch (ex) {
      log.d(' Outer Exception: $ex');
    }
  }

  void _updateBody(CustomChipShape con) {
    con.body.setType(BodyType.dynamic);
    con.body.gravityOverride = Vector2(0, 1000);
    con.body.fixtures.first.friction = 1;
    con.body.fixtures.first.restitution = 0;
  }
}
