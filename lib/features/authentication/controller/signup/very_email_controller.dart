import 'dart:async';

import 'package:app1/common/widgets/success_screen/success_screen.dart';
import 'package:app1/ultis/constants/images_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/snackbar/snackbar.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../ultis/exception/firebase_auth_exception.dart';

class VeryEmailController extends GetxController {
  final emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    setTimerForAutoRedirect();
    sendEmailVerification();
  }

  Future<void> sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.veryEmail();
      TSnackBar.showSuccessSnackBar('Email đã được gửi',
          title: '', message: '');
    } catch (e) {
      TSnackBar.showErrorSnackBar(
        title: 'Lỗi',
        message: TFirebaseAuthException(e.toString()).message,
      );
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();

        Get.off(() => SuccessScreen(
              image: TImages.adidas2,
              title: 'Verify email success',
              subtitle: 'You can now login to your account',
              onPressed: () =>
                  AuthenticationRepository.instance.screenRedirect(),
            ));
      }
    });
  }

  checkEmailVerificationStatus() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      Get.off(() => SuccessScreen(
            image: TImages.adidas2,
            title: 'Verify email success',
            subtitle: 'You can now login to your account',
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ));
    }
  }
}
