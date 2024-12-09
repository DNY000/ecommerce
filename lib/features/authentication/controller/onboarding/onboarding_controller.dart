// ignore: unused_import
import 'package:app1/features/shop/screens/home/home_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../screens/login/login.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();
  // final _showLoading = true.obs;
  // bool get showLoading => _showLoading.value;
  final pageController = PageController();
  final Rx<int> currentPage = 0.obs;

  void updateCurrentPage(int value) {
    currentPage.value = value;
  }

  // Future<void> checkShowLoading() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   _showLoading.value = false;
  // }

  void nextPage() {
    if (currentPage.value == 2) {
      Get.offAll(() => const LoginScreen());
      // _showLoading.value = false;
    } else {
      pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
    }
  }

  void skipPage() {
    currentPage.value = 2;
    pageController.jumpToPage(2);
  }

  void doNavigationClick(index) {
    currentPage.value = index;
    pageController.jumpTo(index);
  }
}
