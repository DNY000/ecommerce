import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../data/services/firebase_service/firebase_notifications_service/get_service_key.dart';
import '../../../../data/services/firebase_service/firebase_notifications_service/notification_service.dart';
import '../../../personalization/screens/settings/settings.dart';
import '../../models/brand_model.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/store/store_screen.dart';
import '../../screens/wishlist/favourite_screen.dart';

class NavigatorController extends GetxController {
  static NavigatorController get instance => Get.find();
  final GetServiceKey getServiceKey = GetServiceKey();
  final NotificationService notificationService = NotificationService();
  final Rx<int> index = 0.obs;

  final listPage = [
    const HomeScreen(),
    StoreScreen(
      categoryModel: CategoryModel.empty(),
      productModel: ProductModel.empty(),
      brandModel: BrandModel.empty(),
    ),
    const Favouritescreen(),
    const SettingsScreen()
  ];

  @override
  void onInit() {
    super.onInit();
    initializeNotifications();
    getServiceKey.getServiceKeyToken();
  }

  Future<void> initializeNotifications() async {
    try {
      // Yêu cầu quyền thông báo
      notificationService.requestPermission();

      // Lấy FCM token
      await notificationService.getToken();

      // Khởi tạo Firebase nếu có context
      if (Get.context != null) {
        notificationService.firebaseInit(Get.context!);
        await notificationService.setupInteractMessage(Get.context!);
      }

      // Lắng nghe tin nhắn khi app đang chạy
      FirebaseMessaging.onMessage.listen((message) {
        notificationService.showNotification(message);
      });
    } catch (e) {
      if (kDebugMode) {
        print('Lỗi khởi tạo notification: $e');
      }
    }
  }
}
