import 'package:app1/common/widgets/snackbar/snackbar.dart';
import 'package:app1/ultis/exception/firebase_exception.dart';
import 'package:app1/ultis/exception/platform_exception.dart';
import 'package:app1/ultis/navigator_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TFirebaseAuthService {
  final FirebaseAuth _db = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Đăng nhập với email và password
  Future<void> signInEmailWithPassword(
      String email, String password, BuildContext context) async {
    try {
      final userCredential = await _db.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        await Future.delayed(const Duration(seconds: 2), () {
          TSnackBar.showSuccessSnackBar('Đăng nhập thành công',
              title: '',
              message: 'CHòa mừng bạn đã đến với bình nguyên vô tận');
        });
        Get.offAll(() => const NavigatorMenu());
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went strong. Please try again ${e.toString()}';
    }
  }

  // Đăng ký tài khoản mới
  // Future<UserCredential> signUp(String email, String password) async {
  //   try {
  //     return await _db.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went strong. Please try again ${e.toString()}';
  //   }
  // }

  // Đăng nhập với Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger Google Sign In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // Lấy thông tin xác thực
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Tạo credential cho Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Đăng nhập vào Firebase
      return await _db.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went strong. Please try again ${e.toString()}';
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _db.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went strong. Please try again ${e.toString()}';
    }
  }

  // ... các phương thức khác giữ nguyên ...

  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Bắt đầu flow đăng nhập Facebook
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      // Kiểm tra kết quả
      if (loginResult.status == LoginStatus.success) {
        // Lấy access token từ Facebook
        final AccessToken accessToken = loginResult.accessToken!;

        // Tạo credential cho Firebase
        final OAuthCredential credential = FacebookAuthProvider.credential(
          accessToken.tokenString,
        );

        // Đăng nhập vào Firebase
        return await _db.signInWithCredential(credential);
      }

      return null;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went strong. Please try again ${e.toString()}';
    }
  }
}
