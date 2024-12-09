import 'package:app1/common/widgets/loaders/loader.dart';
import 'package:app1/common/widgets/poppup/full_screen_loader.dart';
import 'package:app1/data/repositories/authentication/authentication_repository.dart';
import 'package:app1/data/repositories/order/order_repository.dart';
import 'package:app1/features/personalization/controller/address_controller.dart';
import 'package:app1/features/shop/controllers/cart/cart_controller.dart';
import 'package:app1/features/shop/controllers/checkout/checkout_controller.dart';
import 'package:app1/features/shop/models/order_model.dart';
import 'package:app1/ultis/constants/images_string.dart';
import 'package:app1/ultis/navigator_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../ultis/constants/enum.dart';

class OrderController extends GetxController {
  static OrderController get intance => Get.find();

  final CartController cartController = CartController.instance;
  final AddressController addressController = Get.put(AddressController());
  final CheckoutController checkoutController = Get.put(CheckoutController());
  final OrderRepository orderRepository = Get.put(OrderRepository());
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
