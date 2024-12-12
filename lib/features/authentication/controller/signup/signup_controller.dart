import 'package:app1/common/widgets/snackbar/snackbar.dart';
import 'package:app1/data/repositories/authentication/authentication_repository.dart';
import 'package:app1/features/authentication/screens/signup/widgets/very_email.dart';
import 'package:app1/ultis/constants/images_string.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/user/user_repository.dart';
import '../../../../common/widgets/poppup/full_screen_loader.dart';
import '../../../../data/services/firebase_service/firebase_notifications_service/notification_service.dart';
import '../../../shop/models/user_model.dart';
import '../network/network_manager.dart';

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

      final isConnected = await NetworkManager.to.checkConnection();
      if (!isConnected) {
        TFullScreenLoader.closeLoadingDialog();
        return;
      }

      if (signupFormKey.currentState!.validate()) {
        TFullScreenLoader.closeLoadingDialog();
        return;
      }
      if (!privacyPolicy.value) {
        TSnackBar.showWarningSnackBar(
          title: "Accept Privary",
          message: 'Phai chap nhan dieu khoan tren',
        );
        return;
      }
      TFullScreenLoader.openLoadingDialog(
          'Signing up...', TImages.animationLoader);
      final userCredential =
          await AuthenticationRepository.instance.registerEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );
      final token = await NotificationService().getToken();
      final newUser = UserModel(
        id: userCredential.user!.uid,
        email: email.text.trim(),

        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        userName: userName.text.trim(),
        phoneNumber: numberPhone.text.trim(),
        profilePicture: '',
        token: token ?? '',
        //  address: [],
      );
      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(newUser);
      TSnackBar.showSuccessSnackBar('Đăng ký thành công',
          title: 'Đăng ký thành công', message: 'Vui long kiem tra email');
      Get.to(() => VeryEmailScreen(email: email.text.trim()));
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      // TLoader.showCustomToast(message: e.toString());
    } on PlatformException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      // TLoader.showCustomToast(message: e.toString());
    } catch (e) {
      // Fluttertoast.showToast(msg: e.toString());
      // TLoader.showCustomToast(message: e.toString());
    } finally {
      TFullScreenLoader.closeLoadingDialog();
    }
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    firstName.dispose();
    lastName.dispose();
    userName.dispose();
    numberPhone.dispose();

    super.onClose();
  }
}
