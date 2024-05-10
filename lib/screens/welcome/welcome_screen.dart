import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:helm_demo/screens/welcome/widgets/flame_animation.dart';
import 'package:helm_demo/screens/welcome/widgets/welcome_btn_widget.dart';
import 'package:helm_demo/screens/welcome/widgets/welcome_top_texts_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late double scWidth;
  late double scHeight;
  @override
  Widget build(BuildContext context) {
    scWidth = MediaQuery.of(context).size.width;
    scHeight = MediaQuery.of(context).size.height;

    print('scwidth: $scWidth');
    print('scHeight: $scHeight');
    return Scaffold(
      backgroundColor:  const Color(0xFFFCE469),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
        child: Stack(
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WelcomeTopTextsWidget(),
                Row(
                  children: [
                    Expanded(child: WelcomeButtonWidget()),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 250,
              child: SizedBox(
                height: 400,
                width: 400,
                child: GameWidget(
                  game: FlameAnimation(
                    scWidth: scWidth * 0.92,
                    scHeight: 400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
