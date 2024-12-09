import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../loaders/animation_loader.dart';

class TFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    if (Get.overlayContext == null) return;

    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (BuildContext context) => PopScope(
        canPop: false,
        child: Container(
          color:
              TheplerFunction.isDarkMode(context) ? Colors.black : Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250),
              TAnimationLoader(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }

  static void closeLoadingDialog() {
    if (Get.overlayContext == null) return;
    if (Navigator.canPop(Get.overlayContext!)) {
      Navigator.pop(Get.overlayContext!);
    }
  }
}
