import 'package:app1/features/authentication/screens/onboarding/widgets/onboarding_dot_navigator.dart';
import 'package:app1/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:app1/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:app1/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:app1/ultis/constants/images_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/onboarding/onboarding_controller.dart';

class OnboardingSreen extends StatelessWidget {
  const OnboardingSreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: controller.pageController,
          onPageChanged: controller.updateCurrentPage,
          children: const [
            OnBoadingPage(
              image: TImages.onboarding,
            ),
            OnBoadingPage(
              image: TImages.onboarding1,
            ),
            OnBoadingPage(
              image: TImages.onboarding2,
            )
          ],
        ),
        const OnBoardingSkip(),
        const OnBoardingDotNavigator(),
        const OnBoardingNextButton(),
      ],
    ));
  }
}
