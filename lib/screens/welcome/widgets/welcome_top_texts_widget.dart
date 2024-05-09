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
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          AppStrings.welcomeHelm,
          style: AppTextStyles.title,
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
