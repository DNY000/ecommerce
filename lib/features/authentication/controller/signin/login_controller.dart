import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../common/widgets/loaders/loader.dart';
import '../../../../common/widgets/snackbar/snackbar.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../ultis/constants/images_string.dart';
import '../../../../ultis/exception/firebase_exception.dart';
import '../../../../ultis/exception/platform_exception.dart';
import '../../../shop/screens/navigator_menu/navigator_menu.dart';
import '../../../../common/widgets/poppup/full_screen_loader.dart';
import '../network/network_manager.dart';
import '../user/user_controller.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final isShowPassword = false.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();
  final userController = Get.put(UserController());
  @override
  void onInit() {
    emailController.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    passwordController.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  Future<void> signInEmailWithPassword() async {
    try {
      final isConnected = await NetworkManager.to.checkConnection();
      if (!isConnected) {
        TFullScreenLoader.closeLoadingDialog();
        TSnackBar.showErrorSnackBar(
            title: "Loi mang", message: 'Kiem tra lai ket noi');
        return;
      }
      TFullScreenLoader.openLoadingDialog(
          'Đang đăng nhập', TImages.animationLoader);
      //check interner

      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.closeLoadingDialog();
        return;
      }

      //check remember me
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', emailController.text.trim());
        localStorage.write(
            'REMEMBER_ME_PASSWORD', passwordController.text.trim());
      } else {
        localStorage.remove('REMEMBER_ME_EMAIL');
        localStorage.remove('REMEMBER_ME_PASSWORD');
      }
      final userCredential =
          await AuthenticationRepository.instance.signInEmailWithPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      TFullScreenLoader.closeLoadingDialog();
      if (userCredential.user != null) {
        await Future.delayed(const Duration(seconds: 1), () {
          TSnackBar.showSuccessSnackBar("",
              title: " Đăng nhâp thành công", message: "");
        });
        Get.offAll(() => const NavigatorMenu());
      }
      AuthenticationRepository.instance.screenRedirect();
    } on FirebaseAuthException catch (e) {
      // throw TFirebaseException(e.code).message;
      TSnackBar.showErrorSnackBar(
          title: TFirebaseException(e.code).message, message: "");
      TFullScreenLoader.closeLoadingDialog();
    } on PlatformException catch (e) {
      TSnackBar.showErrorSnackBar(
          title: TPlatformException(e.code).message, message: "message");

      // throw TPlatformException(e.code).message;
    } catch (e) {
      TSnackBar.showErrorSnackBar(title: "Lỗi rồi", message: e.toString());
      throw 'Something went strong. Please try again ${e.toString()}';
    } finally {
      TFullScreenLoader.closeLoadingDialog();
    }
  }

  // login with google
  Future<void> signInWithGoogle() async {
    try {
      // 1. Kiểm tra kết nối mạng
      final isConnected = await NetworkManager.to.checkConnection();
      if (!isConnected) {
        TSnackBar.showErrorSnackBar(
          title: 'Lỗi kết nối',
          message: 'Vui lòng kiểm tra kết nối mạng',
        );
        return;
      }

      // 2. Hiển thị loading
      TFullScreenLoader.openLoadingDialog(
          'Đang đăng nhập', TImages.animationLoader);

      // 3. Thực hiện đăng nhập
      final userCredential =
          await AuthenticationRepository.instance.signInWithGoogle();

      // 4. Đóng loading trước khi kiểm tra kết quả
      TFullScreenLoader.closeLoadingDialog();

      // 5. Kiểm tra nếu user hủy đăng nhập
      if (userCredential == null) {
        //  print('User cancelled Google Sign In');
        return;
      }

      // 6. Lưu thông tin user
      await userController.saveRecordUser(userCredential);

      // 7. Hiển thị thông báo thành công
      TSnackBar.showSuccessSnackBar('Đăng nhập thành công',
          title: '',
          message: 'Chào mừng ${userCredential.user?.displayName ?? ""}');

      // 8. Chuyển hướng
      Get.offAll(() => const NavigatorMenu());
    } on FirebaseAuthException catch (e) {
      TLoader.showCustomToast(message: 'Lôi đăng nhập vui lòng thử lại');
      throw "Lỗi đăng nhập: ${TFirebaseException(e.code).message}";
    } on PlatformException catch (e) {
      TLoader.showCustomToast(message: 'Lôi đăng nhập vui lòng thử lại');
      throw "Lỗi đăng nhập: ${TPlatformException(e.code).message}";
    } finally {
      TFullScreenLoader.closeLoadingDialog();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
