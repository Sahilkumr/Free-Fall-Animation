import 'dart:async';
import 'dart:ui';

import 'package:easy_physics_2d/gravity_field.dart';
import 'package:easy_physics_2d/objects.dart';
import 'package:flutter/material.dart';
import 'package:helm_demo/screens/welcome/widgets/custom_gravityfield.dart';
import 'package:helm_demo/screens/welcome/widgets/custom_physicsobj.dart';

class ChipAnimationWidget extends StatefulWidget {
  const ChipAnimationWidget({super.key});

  @override
  State<ChipAnimationWidget> createState() => _ChipAnimationWidgetState();
}

class _ChipAnimationWidgetState extends State<ChipAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animCon;

  late double scWidth;
  late double scHeight;

  List iPos = [];
  List fPos = [];

  List<dynamic> objects = [];
  List<Paint> paintList = [];

  Path draw1 = Path();
  Path draw2 = Path();
  Path draw3 = Path();
  Path draw4 = Path();

  dynamic ball;
  dynamic ball2;
  dynamic ball3;
  dynamic ball4;

  Paint paint1 = Paint()
    ..color = const Color(0xff263e63)
    ..style = PaintingStyle.fill
    ..strokeWidth = 0.5;

  Paint paint2 = Paint()
    ..color = const Color(0xff15693b)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0.5;

  Paint paint3 = Paint()
    ..color = const Color.fromARGB(15, 103, 235, 240)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0.5;

  Paint paint4 = Paint()
    ..color = const Color.fromARGB(15, 103, 235, 240)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0.5;

  ValueNotifier<List<dynamic>> dropObject = ValueNotifier([]);

  @override
  void initState() {
    super.initState();

    animCon = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1),
    );
    animCon.repeat();

    for (double i = 0; i < 20 - 1; i++) {
      draw1.addRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(0, -50, 100, 50),
          const Radius.circular(30),
        ),
      );
      draw2.addRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(0, -50, 100, 100),
          const Radius.circular(30),
        ),
      );
      draw3.addRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(0, -50, 100, 50),
          const Radius.circular(30),
        ),
      );
      draw4.addRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(0, -50, 100, 50),
          const Radius.circular(30),
        ),
      );
    }

    paintList = [paint1, paint2, paint3, paint4];

    ball = MyBall(
      xPoint: 0,
      yPoint: 100,
      xVelocity: 0,
      yVelocity: 0,
      ballRadius: 20,
      ballMass: 0.5,
      angularVelocity: 0,
      ballPaint: paintList,
      ballPath: [draw1, draw3, draw2, draw4],
    );

    ball2 = MyBall(
        xPoint: 10,
        yPoint: 100,
        xVelocity: 0,
        yVelocity: 0,
        ballRadius: 20,
        ballMass: 0.5,
        angularVelocity: 0,
        ballPaint: paintList,
        ballPath: [draw3, draw1, draw2, draw4]);
    ball3 = MyBall(
      xPoint: 170,
      yPoint: 100,
      xVelocity: 0,
      yVelocity: 0,
      ballRadius: 22,
      ballMass: 0.5,
      angularVelocity: 0,
      ballPaint: paintList,
      ballPath: [draw1, draw3, draw2, draw4],
    );
    ball4 = MyBall(
      xPoint: 230,
      yPoint: 200,
      xVelocity: 0,
      yVelocity: 0,
      ballRadius: 30,
      ballMass: 0.5,
      angularVelocity: 0,
      ballPath: [draw4, draw3],
      ballPaint: paintList,
    );

    objects = [ball, ball2, ball3, ball4];
  }

  @override
  void dispose() {
    super.dispose();
    animCon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scWidth = MediaQuery.of(context).size.width;
    scHeight = MediaQuery.of(context).size.height * 0.5;
    return ValueListenableBuilder(
      valueListenable: dropObject,
      builder: (context, value, child) => Container(
          padding: const EdgeInsets.all(20),
          color: Colors.transparent,
          child: CustomGravityField(
            mapColor: Colors.transparent,
            mapX: scWidth,
            titles: const [
              'con1',
              'con2',
              'con3',
              'con4',
            ],
            mapY: scHeight,
            objects: objects,
            gravity: 300,
            elasticConstant: 0.3,
          )),
    );
  }
}
