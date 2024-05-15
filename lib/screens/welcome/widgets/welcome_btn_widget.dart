import 'package:flutter/material.dart';
import 'package:helm_demo/constants/strings/styles/text_styles.dart';

class WelcomeButtonWidget extends StatelessWidget {
  const WelcomeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black,
      ),
      child: const Center(
        child: Text(
          'Let\'s get started!',
          style: AppTextStyles.btnWht,
        ),
      ),
    );
  }
}
