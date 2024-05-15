import 'package:flutter/material.dart';
import 'package:flame/game.dart' as flame;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helm_demo/constants/strings/app_strings.dart';
import 'package:helm_demo/constants/strings/styles/text_styles.dart';
import 'package:helm_demo/screens/welcome/cubit/mid_tag_line_cubit.dart';
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

class _WelcomeScreenState extends State<WelcomeScreen> {
  late MidTagLineCubit animEndCubit;

  @override
  void initState() {
    super.initState();
    animEndCubit = MidTagLineCubit();
  }

  @override
  void dispose() {
    super.dispose();
    animEndCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE469),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const WelcomeTopTextsWidget(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return flame.GameWidget(
                            game: flame_anim.FlameAnimation(
                              scWidth: constraints.maxWidth,
                              scHeight: constraints.maxHeight,
                              animCubit: animEndCubit,
                              chipDropPoint:
                                  widget.scHeight - constraints.maxHeight,
                            ),
                          );
                        },
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
                      if (state is MidTagLineDisplay) {
                        return SizedBox(
                          width: widget.scWidth,
                          child: Text(
                            AppStrings.middleTagLine,
                            style: AppTextStyles.titleOp50,
                            maxLines: 2,
                            textAlign: TextAlign.left,
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
      ),
    );
  }
}
