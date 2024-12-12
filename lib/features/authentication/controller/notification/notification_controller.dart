import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/notification/notification_repository.dart';
import '../../../../data/services/firebase_service/firebase_notifications_service/notification_service.dart';
import '../../../../ultis/exception/firebase_exception.dart';
import '../../../../ultis/exception/platform_exception.dart';
import '../../../shop/models/notification_model.dart';

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find();
  final NotificationService notificationService = NotificationService();
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxBool refreshData = true.obs;
  RxInt countUnread = 0.obs;
  final NotificationRepository notificationRepository =
      Get.put(NotificationRepository());
  @override
  void onInit() {
    fetchNotifications();
    getCountUnread();
    super.onInit();

    // requestPermission();
  }

  Future<void> saveNotification(NotificationModel notification) async {
    try {
      await notificationRepository.saveNotification(notification);
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<NotificationModel>> fetchNotifications() async {
    try {
      final notification = await notificationRepository.fetchNotifications();
      notifications.assignAll(notification);

      return notifications;
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getCountUnread() async {
    final count = await notificationRepository.getCountUnread();
    countUnread.value = count;
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      // Cập nhật trạng thái trong Firestore
      await notificationRepository.markAsRead(notificationId);

      refreshData.toggle();
      // Cập nhật số lượng thông báo chưa đọc
      await getCountUnread();
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi: $e');
      }
      Get.snackbar(
        'Lỗi',
        'Không thể đánh dấu đã đọc $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
      );
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      await notificationRepository.deleteNotification(notificationId);
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception(e);
    }
  }
}
