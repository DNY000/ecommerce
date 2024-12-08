import 'package:app1/common/widgets/snackbar/snackbar.dart';
import 'package:app1/data/repositories/authentication/authentication_repository.dart';
import 'package:app1/features/authentication/screens/signup/widgets/very_email.dart';
import 'package:app1/ultis/constants/images_string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/user/user_repository.dart';
import '../../../../common/widgets/poppup/full_screen_loader.dart';
import '../../../shop/models/user_model.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final hintPassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final numberPhone = TextEditingController();
  final signupFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      //check mạng internet
      TFullScreenLoader.openLoadingDialog(
          'Signing up...', TImages.animationLoader);
      // final isConnected = await NetworkManager.to.checkConnection();
      // if (!isConnected) {
      //   TFullScreenLoader.closeLoadingDialog();
      //   return;
      // }
      if (signupFormKey.currentState!.validate()) {
        TFullScreenLoader.closeLoadingDialog();
      }
      if (!privacyPolicy.value) {
        TSnackBar.showWarningSnackBar(
          title: "Accept Privary",
          message: 'Phai chap nhan dieu khoan tren',
        );
        return;
      }
      final userCredential =
          await AuthenticationRepository.instance.registerEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );
      final newUser = UserModel(
        id: userCredential.user!.uid,
        email: email.text.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        userName: userName.text.trim(),
        phoneNumber: numberPhone.text.trim(),
        profilePicture: '',
        //  address: [],
      );
      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(newUser);
      TSnackBar.showSuccessSnackBar('Đăng ký thành công',
          title: '', message: '');
      Get.to(() => VeryEmailScreen(email: email.text.trim()));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      TFullScreenLoader.closeLoadingDialog();
    }
  }
}
