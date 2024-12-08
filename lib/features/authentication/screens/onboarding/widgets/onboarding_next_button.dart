import 'package:app1/features/authentication/controller/onboarding/onboarding_controller.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = TheplerFunction.isDarkMode(context);
    return Positioned(
      right: 20,
      bottom: 56,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: dark ? Colors.grey.shade600 : Colors.black,
              shape: const CircleBorder()),
          onPressed: () {
            OnboardingController.instance.nextPage();
          },
          child: const Icon(Iconsax.arrow_right_3)),
    );
  }
}
