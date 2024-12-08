import 'package:app1/features/shop/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/user/user_repository.dart';
import '../../../../data/services/imgur_service/imgur_service.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final userRepository = Get.put(UserRepository());
  final imgurService = Get.put(ImgurService());
  Rx<UserModel> user = UserModel.empty().obs;
  RxBool isLoading = false.obs;
  RxString avatarUrl = ''.obs;
  RxString tempImageUrl = ''.obs;
  RxList<Map<String, dynamic>> userImages = <Map<String, dynamic>>[].obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserDetail();
    loadAvatar();
  }

  Future<void> loadAvatar() async {
    final url = await userRepository.getLatestAvatarUrl();
    if (url != null && url.isNotEmpty) {
      avatarUrl.value = url;
    }
  }

  void getAllImage() async {
    final images = await imgurService.getAllImages();
    if (kDebugMode) {
      print(images);
    }
  }

  Future<void> saveRecordUser(UserCredential? user) async {
    try {
      if (user != null) {
        final namePart = UserModel.nameParts(user.user!.displayName ?? "");
        final username =
            UserModel.generateUserName(user.user!.displayName ?? '');

        final userModel = UserModel(
          id: user.user!.uid,
          firstName: namePart[0],
          lastName: namePart.length > 1 ? namePart.sublist(1).join(" ") : '',
          userName: username,
          phoneNumber: user.user!.phoneNumber ?? " ",
          profilePicture: user.user!.photoURL ?? '',
          email: user.user!.email ?? '',
          //   address: [],
        );
        await userRepository.createUser(userModel);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // fetch user detail
  Future<void> fetchUserDetail() async {
    try {
      isLoading.value = true;
      final user = await userRepository.fetchUsersDeltail();
      this.user(user);
      isLoading.value = false;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  // upload image
  Future<String?> uploadImageFromGallery() async {
    try {
      final imageUrl = await userRepository.pickImage();
      if (imageUrl != null) {
        tempImageUrl.value = imageUrl;
      }
      return imageUrl;
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể chọn ảnh: $e');
      return null;
    }
  }

  Future<String?> uploadImageFromCamera() async {
    try {
      final imageUrl = await userRepository.photoImage();
      if (imageUrl != null) {
        tempImageUrl.value = imageUrl;
      }
      return imageUrl;
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể chụp ảnh: $e');
      return null;
    }
  }

  Future<void> saveSelectedImage() async {
    try {
      isLoading.value = true;
      if (tempImageUrl.value.isNotEmpty) {
        // Cập nhật user model
        final updateUser =
            user.value.copyWith(profilePicture: tempImageUrl.value);

        // Cập nhật Firebase và storage
        await userRepository.updateUser(updateUser);

        // Cập nhật UI
        user.value = updateUser;
        avatarUrl.value = tempImageUrl.value;
        tempImageUrl.value = '';

        Get.back();
        Get.snackbar(
          'Thành công',
          'Đã cập nhật ảnh đại diện',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Không thể cập nhật ảnh: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> clearAvatarUrl() async {
    try {
      isLoading.value = true;
      await userRepository.clearAvatarUrl();
      final updateUser = user.value.copyWith(profilePicture: '');
      await userRepository.updateUser(updateUser);
      avatarUrl.value = '';
      isLoading.value = false;
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadUserImages() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final images = await imgurService.getAllImages();

      if (images != null) {
        userImages.value = images;
      } else {
        errorMessage.value = 'Không thể tải ảnh. Vui lòng thử lại sau.';
      }
    } catch (e) {
      errorMessage.value = 'Lỗi: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
