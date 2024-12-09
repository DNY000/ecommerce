import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/snackbar/snackbar.dart';
import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../ultis/constants/images_string.dart';
import '../../../../common/widgets/poppup/full_screen_loader.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();
  final AuthenticationRepository authenticationRepository =
      Get.put(AuthenticationRepository());
  final emailController = TextEditingController();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  Future<void> forgotPassword() async {
    try {
      TFullScreenLoader.openLoadingDialog(
        'Đang gửi email',
        TImages.animationLoader,
      );
      // final isConnected = await NetworkManager.to.checkConnection();
      // if (!isConnected) {
      //   TFullScreenLoader.closeLoadingDialog();
      //   return;
      // }
      if (!forgotPasswordFormKey.currentState!.validate()) {
        TSnackBar.showErrorSnackBar(
          title: 'Error',
          message: 'Please enter a valid email',
        );
        return;
      }

      await authenticationRepository
          .forgotPassword(emailController.text.trim());

      TFullScreenLoader.closeLoadingDialog();
      TSnackBar.showSuccessSnackBar('Password reset email sent',
          title: '', message: '');
      Get.to(() => SuccessScreen(
            title: 'Success',
            subtitle: 'Password reset email sent',
            image: TImages.aoKhoac2,
            onPressed: () {
              Get.back();
            },
          ));
    } catch (e) {
      TFullScreenLoader.closeLoadingDialog();
      TSnackBar.showErrorSnackBar(
        title: 'Error',
        message: e.toString(),
      );
    }
  }
}
