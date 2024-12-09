import 'package:app1/features/authentication/controller/network/network_manager.dart';
import 'package:app1/features/authentication/screens/login/login.dart';
import 'package:app1/features/authentication/screens/onboarding/onboarding.dart';
import 'package:app1/ultis/exception/platform_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../features/authentication/screens/signup/widgets/very_email.dart';
import '../../../ultis/exception/firebase_auth_exception.dart';
import '../../../ultis/exception/firebase_exception.dart';
import '../../../ultis/navigator_menu.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository instance = Get.find();
  final devicesStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get userAuth => _auth.currentUser;
  @override
  void onReady() {
    super.onReady();
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    final user = _auth.currentUser;
    final isConnected = await NetworkManager.to.checkConnection();
    if (!isConnected) {
      return null;
    }
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigatorMenu());
      } else {
        Get.offAll(() => VeryEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      devicesStorage.writeIfNull('IsFirstTime', true);
      devicesStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(const OnboardingSreen());
    }
  }

  //register email and password
  Future<UserCredential> registerEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> veryEmail() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      throw TFirebaseAuthException(e.toString());
    }
  }

  Future<UserCredential> signInEmailWithPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      throw "$e";
    }
  }

  // login with google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // 1. Khởi tạo GoogleSignIn với cấu hình cụ thể
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'profile',
        ],
        signInOption: SignInOption.standard,
      );

      // 2. Bắt đầu quá trình đăng nhập
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // print('Google Sign In: User cancelled');
        return null;
      }

      // 3. Lấy thông tin xác thực
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // print('Google Auth: Access Token - ${googleAuth.accessToken}');
      // print('Google Auth: ID Token - ${googleAuth.idToken}');

      // 4. Tạo credential cho Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 5. Đăng nhập Firebase
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // print('Firebase Auth Error: ${e.code} - ${e.message}');
      throw 'Lỗi xác thực: ${e.message}';
    } on PlatformException catch (e) {
      //    print('Platform Error: ${e.code} - ${e.message}');
      throw 'Lỗi kết nối Google: Vui lòng thử lại $e';
    } catch (e) {
      // print('General Error: $e');
      throw 'Lỗi không xác định: Vui lòng thử lại sau';
    }
  }

  // forgot password
  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went strong. Please try again ${e.toString()}';
    }
  }
}
