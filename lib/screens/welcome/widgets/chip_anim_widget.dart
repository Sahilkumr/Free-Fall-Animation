import 'dart:math';
import 'package:easy_physics_2d/gravity_field.dart';
import 'package:easy_physics_2d/objects.dart';
import 'package:flutter/material.dart';

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
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  Paint paint2 = Paint()
    ..color = const Color(0xff15693b)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  Paint paint3 = Paint()
    ..color = const Color.fromARGB(15, 103, 235, 240)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  Paint paint4 = Paint()
    ..color = const Color.fromARGB(15, 103, 235, 240)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  ValueNotifier<List<dynamic>> dropObject = ValueNotifier([]);

  @override
  void initState() {
    super.initState();

    animCon = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1),
    );
    animCon.repeat();

    // Timer.periodic(
    //   const Duration(milliseconds: 1000),
    //   (timer) {
    //     dropObject.value.add(objects);
    //     print('add object: ${dropObject.value.length}');
    //   },
    // );

    objects = [];

    for (double i = 0; i < 20 - 1; i++) {
      draw1.arcTo(
          Rect.fromCircle(
            radius: i,
            center: const Offset(
              0,
              0,
            ),
          ),
          0,
          (1.5 * pi),
          true);

      draw2.arcTo(
          Rect.fromCircle(
            radius: i,
            center: const Offset(
              0,
              0,
            ),
          ),
          1.5 * pi,
          0.5 * pi,
          true);

      draw3.arcTo(
          Rect.fromCircle(
            radius: i,
            center: const Offset(0, 0),
          ),
          3.5 * pi,
          0.5 * pi,
          true);

      draw4.addRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(0, -50, 100, 50),
          const Radius.circular(10),
        ),
      );
    }

    paintList = [paint1, paint2, paint3, paint4];
    ball = myBall(
      xPoint: 140,
      yPoint: 230,
      xVelocity: 0,
      yVelocity: 0,
      ballRadius: 30,
      ballMass: 0.5,
      angularVelocity: 0,
      ballPaint: paintList,
    );

    ball2 = myBall(
      xPoint: 150,
      yPoint: 100,
      xVelocity: 0,
      yVelocity: 0,
      ballRadius: 20,
      ballMass: 0.5,
      angularVelocity: 0,
      ballPath: [draw1, draw2, draw3, draw4],
    );
    ball3 = myBall(
      xPoint: 250,
      yPoint: 100,
      xVelocity: 0,
      yVelocity: 0,
      ballRadius: 20,
      ballMass: 0.5,
      angularVelocity: 0,
      ballPath: [draw1, draw2, draw3, draw4],
    );
    ball4 = myBall(
      xPoint: 10,
      yPoint: 200,
      xVelocity: 0,
      yVelocity: 0,
      ballRadius: 1,
      ballMass: 0.5,
      angularVelocity: 0,
      ballPath: [draw4],
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
    scHeight = MediaQuery.of(context).size.height * 0.55;
    return ValueListenableBuilder(
      valueListenable: dropObject,
      builder: (context, value, child) => Container(
        padding: const EdgeInsets.all(20),
        color: Colors.transparent,
        child: GravityField(
          objects: objects,
          gravity: 500,
          mapColor: Colors.transparent,
          mapX: scWidth,
          mapY: scHeight,
          elasticConstant: 0.3,
          frictionConstant: 0.5,
        ),
      ),
    );
  }
}
