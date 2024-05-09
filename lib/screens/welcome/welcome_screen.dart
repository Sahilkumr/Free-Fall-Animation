import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 228, 105),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 80, 20, 20),
        child: Stack(
          children: [
            Column(
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
              top: 200,
              child: ChipAnimationWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
