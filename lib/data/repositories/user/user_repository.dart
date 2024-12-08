import 'dart:io';

import 'package:app1/data/repositories/authentication/authentication_repository.dart';
import 'package:app1/ultis/exception/firebase_exception.dart';
import 'package:app1/ultis/exception/platform_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../features/shop/models/user_model.dart';
import '../../services/imgur_service/imgur_service.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final storage = GetStorage();
  final ImgurService _imgurService = ImgurService();
  final ImagePicker _imagePicker = ImagePicker();
  static const String avatarKey = 'USER_AVATAR_URL';
  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection('Users').doc(user.id).set(user.toJson());
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception(e);
    }
  }

  // fetch user
  Future<UserModel> fetchUsersDeltail() async {
    try {
      final snapshot = await _firestore
          .collection('Users')
          .doc(AuthenticationRepository.instance.userAuth?.uid)
          .get();
      if (snapshot.exists) {
        return UserModel.fromSnapshot(snapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Loi $e';
    }
  }

  //update usser
  Future<void> updateUser(UserModel user) async {
    try {
      await _firestore.collection('Users').doc(user.id).update(user.toJson());

      // Lưu URL ảnh vào storage nếu có
      if (user.profilePicture.isNotEmpty) {
        await storage.write(avatarKey, user.profilePicture);
      }
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Lỗi $e';
    }
  }

  //delete user
  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('Users').doc(userId).delete();
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Loi $e';
    }
  }

  Future<void> deleteAccount() async {
    await deleteUser(AuthenticationRepository.instance.userAuth?.uid ?? '');
  }

// upload image

  Future<String?> pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        final imageUrl = await _imgurService.uploadImage(File(image.path));
        if (imageUrl != null) {
          // Lưu URL ảnh vào storage ngay sau khi upload thành công
          await storage.write(avatarKey, imageUrl);
          return imageUrl;
        }
      }
      return null;
    } catch (e) {
      throw 'Lỗi khi chụn ảnh: $e';
    }
  }

  Future<String?> photoImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (image != null) {
        final imageUrl = await _imgurService.uploadImage(File(image.path));
        if (imageUrl != null) {
          // Lưu URL ảnh vào storage ngay sau khi upload thành công
          await storage.write(avatarKey, imageUrl);
          return imageUrl;
        }
      }
      return null;
    } catch (e) {
      throw 'Lỗi khi chụp ảnh: $e';
    }
  }

  String? getAvatarUrl() {
    return storage.read<String>(avatarKey);
  }

  Future<void> clearAvatarUrl() async {
    try {
      // Xóa từ storage
      await storage.remove(avatarKey);

      // Xóa từ Firebase
      final user = await fetchUsersDeltail();
      if (user.id.isNotEmpty) {
        final updatedUser = user.copyWith(profilePicture: '');
        await _firestore
            .collection('Users')
            .doc(user.id)
            .update(updatedUser.toJson());
      }
    } catch (e) {
      throw 'Lỗi khi xóa ảnh: $e';
    }
  }

  // Thêm phương thức để lấy ảnh từ cả Firebase và Storage
  Future<String?> getLatestAvatarUrl() async {
    try {
      // Thử lấy từ storage trước
      final storageUrl = storage.read<String>(avatarKey);
      if (storageUrl != null && storageUrl.isNotEmpty) {
        return storageUrl;
      }

      // Nếu không có trong storage, lấy từ Firebase
      final user = await fetchUsersDeltail();
      if (user.profilePicture.isNotEmpty) {
        // Cập nhật storage với URL từ Firebase
        await storage.write(avatarKey, user.profilePicture);
        return user.profilePicture;
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi khi lấy URL ảnh: $e');
      }
      return null;
    }
  }

  // Thêm phương thức để đồng bộ URL ảnh
  Future<void> syncAvatarUrl() async {
    try {
      final user = await fetchUsersDeltail();
      if (user.profilePicture.isNotEmpty) {
        await storage.write(avatarKey, user.profilePicture);
      } else {
        final storageUrl = storage.read<String>(avatarKey);
        if (storageUrl != null && storageUrl.isNotEmpty) {
          final updatedUser = user.copyWith(profilePicture: storageUrl);
          await _firestore
              .collection('Users')
              .doc(user.id)
              .update(updatedUser.toJson());
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi khi đồng bộ URL ảnh: $e');
      }
    }
  }
}
