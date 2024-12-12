import 'package:app1/common/widgets/loaders/loader.dart';
import 'package:app1/common/widgets/poppup/full_screen_loader.dart';
import 'package:app1/data/repositories/authentication/authentication_repository.dart';
import 'package:app1/data/repositories/order/order_repository.dart';
import 'package:app1/features/personalization/controller/address_controller.dart';
import 'package:app1/features/shop/controllers/cart/cart_controller.dart';
import 'package:app1/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:app1/features/shop/models/order_model.dart';
import 'package:app1/ultis/constants/images_string.dart';
import 'package:app1/features/shop/screens/navigator_menu/navigator_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../data/services/firebase_service/firebase_notifications_service/send_notification_service.dart';
import '../../../../ultis/constants/enum.dart';
import '../../../authentication/controller/notification/notification_controller.dart';
import '../../models/notification_model.dart';

class OrderController extends GetxController {
  static OrderController get intance => Get.find();

  final CartController cartController = CartController.instance;
  final AddressController addressController = Get.put(AddressController());
  final CheckoutController checkoutController = Get.put(CheckoutController());
  final OrderRepository orderRepository = Get.put(OrderRepository());
  final NotificationController notificationController =
      Get.put(NotificationController());
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final orders = await orderRepository.fetchUserOrders();
      if (kDebugMode) {
        print('Fetched ${orders.length} orders');
      }
      return orders;
    } catch (e) {
      TLoader.warningMessage(e.toString());
      if (kDebugMode) {
        print('Lỗi $e');
      }
      return [];
    }
  }

  void processOrder(double totalAmount) async {
    try {
      // Start loader
      TFullScreenLoader.openLoadingDialog(
          'Đang xử lý đơn hàng', TImages.animationLoader);

      // Get user authentication id
      final userId = AuthenticationRepository.instance.userAuth!.uid;
      // if (kDebugMode) {
      //   print(userId);
      // }
      if (userId.isEmpty) return;

      // Add order details
      final order = OrderModel(
          // Generate a unique ID for the order
          id: DateTime.now().toIso8601String(),
          userId: userId,
          status: OrderState.pending,
          totalAmount: totalAmount,
          orderDate: DateTime.now(),
          paymentMethod: checkoutController.selectedPaymentMethod.value.name,
          address: addressController.addressModel.value,
          // Get cart as needed
          deliveryDate: DateTime.now(),
          items: cartController.cartItems.toList()); // OrderModel

      // Save the order to Firestore
      await orderRepository.saveOrder(order, userId);
      await notificationController.saveNotification(NotificationModel(
        id: userId,
        body: 'Đơn hàng ${order.id} của bạn đã được đặt thành công',
        title: 'Đơn hàng mới',
        type: NotificationType.order.name,
        createdAt: DateTime.now(),
        isRead: false,
        data: order.toJson(),
      ));
      await SendNotificationService.sendNotification(
        token:
            "csfmhtHkTwKFMzh4P86-Xo:APA91bHPSkcx7U4k3xqn8TB_QZWKPGIJ-P5t1-7yjQ62N4gQl9QDErduIgFJZs0giX8JcjBlV-K6XZP3QazcnDNj94or1f3ee7J54xWlG5M20wxgL-SqiaM",
        title: 'Đơn hàng mới',
        body: order.status.name,
        data: {'screen': '/notification'},
      );
      // Update the cart status
      cartController.clearCart();
      Get.offAll(
          () => SuccessScreen(
                isLottie: true,
                title: 'Thanh toán thành công',
                subtitle:
                    'Đơn hàng của bạn sẽ được giao trong thời gian sớm nhất',
                image: TImages.paymentSuccess,
                onPressed: () => Get.offAll(() => const NavigatorMenu()),
              ),
          predicate: (route) => false);
    } catch (e) {
      TLoader.warningMessage(e.toString());
    } finally {
      TFullScreenLoader.closeLoadingDialog();
    }
  }
}
