import 'package:flutter/material.dart';
import 'package:helm_demo/constants/strings/app_strings.dart';
import 'package:helm_demo/constants/strings/styles/text_styles.dart';

class WelcomeTopTextsWidget extends StatelessWidget {
  const WelcomeTopTextsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'lib/assets/tree.png',
          height: 70,
          width: 70,
        ),
        const SizedBox(height: 10),
        const Text(
          AppStrings.welcome,
          style: AppTextStyles.title,
          maxLines: 2,
        ),
        const Text(
          AppStrings.welcomeTo,
          style: AppTextStyles.title,
        ),
        const SizedBox(height: 10),
        const Text(
          AppStrings.welcomeToSubText,
          style: AppTextStyles.subTitle,
        ),
      ],
    );
  }
}
