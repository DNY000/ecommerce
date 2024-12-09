import 'package:app1/ultis/device/device.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/onboarding/onboarding_controller.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => OnboardingController.instance.currentPage.value == 2
        ? const SizedBox.shrink() // Ẩn nút khi ở trang cuối
        : Positioned(
            top: TDevice.getAppBarHeight() * 0.5,
            right: 30,
            child: TextButton(
                onPressed: () {
                  OnboardingController.instance.skipPage();
                },
                child: const Text('Skip'))));
  }
}
