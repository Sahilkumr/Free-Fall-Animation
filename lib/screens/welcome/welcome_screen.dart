import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart' as flame;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helm_demo/constants/strings/app_strings.dart';
import 'package:helm_demo/constants/strings/styles/text_styles.dart';
import 'package:helm_demo/screens/welcome/cubit/anim_end_text_cubit.dart';
import 'package:helm_demo/screens/welcome/widgets/flame_animation.dart'
    as flame_anim;
import 'package:helm_demo/screens/welcome/widgets/welcome_btn_widget.dart';
import 'package:helm_demo/screens/welcome/widgets/welcome_top_texts_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    super.key,
    required this.scWidth,
    required this.scHeight,
  });
  final double scWidth;
  final double scHeight;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with WidgetsBindingObserver {
  late AnimEndTextCubit animEndCubit;

  GlobalKey expKey = GlobalKey();

  double expHeight = 0;

  ValueNotifier<double> eHeight = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    animEndCubit = AnimEndTextCubit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox rb = expKey.currentContext!.findRenderObject() as RenderBox;
      eHeight.value = rb.size.height;
      print('Expaned height : ${rb.size.height}');
    });
  }

  @override
  void dispose() {
    super.dispose();
    animEndCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    print('eHeight valueable: ${eHeight.value}');
    print('exHeigh in build: $expHeight');
    // scWidth = MediaQuery.of(context).size.width;
    // scHeight = MediaQuery.of(context).size.height;

    // print('scwidth: $scWidth');
    print('scHeight: ${widget.scHeight}');
    return Scaffold(
      backgroundColor: const Color(0xFFFCE469),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const WelcomeTopTextsWidget(),
                Expanded(
                  child: flame.GameWidget(
                    game: flame_anim.FlameAnimation(
                      scWidth: widget.scWidth * 0.9,
                      scHeight: widget.scHeight * 0.45,
                      animCubit: animEndCubit,
                    ),
                  ),
                ),
                const Row(
                  children: [
                    Expanded(
                      child: WelcomeButtonWidget(),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              child: BlocProvider.value(
                value: animEndCubit,
                child: BlocBuilder(
                  bloc: animEndCubit,
                  builder: (context, state) {
                    if (state is AnimEndTextDisplay) {
                      return SizedBox(
                        width: widget.scWidth * 0.90,
                        child: Center(
                          child: Text(
                            AppStrings.middleTagLine,
                            style: AppTextStyles.titleOp50,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
