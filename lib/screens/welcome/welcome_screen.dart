import 'package:flutter/material.dart';
import 'package:flame/game.dart' as flame;
import 'package:helm_demo/screens/welcome/widgets/flame_animation.dart'
    as flameAnim;
import 'package:helm_demo/screens/welcome/widgets/welcome_btn_widget.dart';
import 'package:helm_demo/screens/welcome/widgets/welcome_top_texts_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with WidgetsBindingObserver {
  late double scWidth;
  late double scHeight;

  GlobalKey expKey = GlobalKey();

  double expHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get the height of the widget after the first frame has been drawn
      setState(() {
        RenderBox rb = expKey.currentContext!.findRenderObject() as RenderBox;
        expHeight = rb.size.height;
        print('Expaned height : ${rb.size.height}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    scWidth = MediaQuery.of(context).size.width;
    scHeight = MediaQuery.of(context).size.height;

    print('scwidth: $scWidth');
    print('scHeight: $scHeight');
    return Scaffold(
      backgroundColor: const Color(0xFFFCE469),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const WelcomeTopTextsWidget(),
                Expanded(
                  key: expKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    child: flame.GameWidget(
                      game: flameAnim.FlameAnimation(
                        scWidth: scWidth * 0.9,
                        scHeight: expHeight * 0.9,
                      ),
                    ),
                  ),
                ),
                const Row(
                  children: [
                    Expanded(child: WelcomeButtonWidget()),
                  ],
                ),
              ],
            ),
            // // Positioned(
            // //   top: 250,
            // //   child: SizedBox(
            // //     width: scWidth * 0.9,
            // //     height: scHeight * 0.45,
            // //     child: flame.GameWidget(
            // //       game: flameAnim.FlameAnimation(
            // //         scWidth: scWidth * 0.9,
            // //         scHeight: scHeight * 0.45,
            // //       ),
            // //     ),
            // //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
