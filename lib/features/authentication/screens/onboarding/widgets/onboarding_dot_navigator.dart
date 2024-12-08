import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../controller/onboarding/onboarding_controller.dart';

class OnBoardingDotNavigator extends StatelessWidget {
  const OnBoardingDotNavigator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = TheplerFunction.isDarkMode(context);
    final controller = OnboardingController.instance;
    return Positioned(
      bottom: 60,
      left: 20,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.doNavigationClick,

        count: 3,
        // chấm tròn
        // effect: const WormEffect(
        //   dotHeight: 10,
        //   dotWidth: 10,
        //   activeDotColor: Colors.black,
        // ),
        // chấm dài xẹp
        effect: ExpandingDotsEffect(
          activeDotColor: dark ? Colors.grey.shade600 : Colors.black,
          dotHeight: 6,
          dotWidth: 10,
          dotColor: Colors.grey,
        ),
        // axisDirection: Axis.horizontal,
      ),
    );
  }
}
