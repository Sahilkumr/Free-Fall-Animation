import 'package:flutter/material.dart';
import 'package:helm_demo/screens/welcome/widgets/chip_anim_widget.dart';
import 'package:helm_demo/screens/welcome/widgets/welcome_btn_widget.dart';
import 'package:helm_demo/screens/welcome/widgets/welcome_top_texts_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 233, 116),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 20,
        ),
        child: Stack(
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WelcomeTopTextsWidget(),
                WelcomeButtonWidget(),
              ],
            ),
            Positioned(
              top: 250,
              child: const Expanded(
                child: ChipAnimationWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
