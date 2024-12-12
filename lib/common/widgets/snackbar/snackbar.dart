import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ultis/constants/constants.dart';

class TSnackBar {
  static void showSuccessSnackBar(
    String s, {
    required String title,
    required String message,
    Duration? duration,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.withOpacity(0.2),
      colorText: Colors.green,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      icon: const Icon(Icons.check_circle, color: Colors.green),
    );
  }

  static void showErrorSnackBar({
    required String title,
    required String message,
    Duration? duration,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.withOpacity(0.1),
      colorText: Colors.red,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      icon: const Icon(Icons.error, color: Colors.red),
    );
  }

  static void showWarningSnackBar({
    required String title,
    required String message,
    Duration? duration,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange.withOpacity(0.1),
      colorText: Colors.orange,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      icon: const Icon(Icons.warning, color: Colors.orange),
    );
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: TSizes.xl),
      title: 'Xóa tài khoản?',
      middleText: 'Bạn có chắc chắn muốn xóa tài khoản?',
      confirm: ElevatedButton(
        onPressed: () {},
        child: const Text('Xóa'),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.context!).pop(),
        child: const Text('Quay lại'),
      ),
    );
  }
}
