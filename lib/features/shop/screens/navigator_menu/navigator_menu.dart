import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:app1/ultis/constants/tcolor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controllers/navigator/navigator_controller.dart';

class NavigatorMenu extends StatelessWidget {
  const NavigatorMenu({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigatorController());
    final darkMode = TheplerFunction.isDarkMode(context);
    // final onBoardingController = Get.put(OnboardingController());
    return Scaffold(
        bottomNavigationBar: Obx(() => NavigationBar(
              height: 80,
              // elevation: 0.3,
              selectedIndex: controller.index.value,
              backgroundColor: Colors.transparent,
              indicatorColor: darkMode
                  ? TColor.white.withOpacity(0.1)
                  : TColor.black.withOpacity(0.1),
              onDestinationSelected: (index) => controller.index.value = index,
              destinations: const [
                NavigationDestination(
                    icon: Icon(
                      FontAwesomeIcons.house,
                    ),
                    label: 'Trang chủ'),
                NavigationDestination(
                    icon: Icon(FontAwesomeIcons.shop), label: 'Cửa hàng'),
                NavigationDestination(
                    icon: Icon(FontAwesomeIcons.heart), label: 'Yêu thích'),
                NavigationDestination(
                    icon: Icon(FontAwesomeIcons.user), label: 'Tài khoản'),
              ],
            )),
        body: Obx(
          () => controller.listPage[controller.index.value],
        ));
  }
}
