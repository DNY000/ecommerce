import 'package:app1/common/appbar/appbar.dart';
import 'package:app1/features/shop/screens/cart/widget/cart_item.dart';
import 'package:app1/features/shop/screens/checkout/checkout.dart';
import 'package:app1/ultis/constants/images_string.dart';
import 'package:app1/common/widgets/loaders/animation_loader.dart';
import 'package:app1/features/shop/screens/navigator_menu/navigator_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Scaffold(
      appBar: const TAppBar(
        title: Text('Cart'),
        showBackArrow: true,
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return TAnimationLoader(
            text: 'Giỏ hàng trống',
            animation: TImages.animationLoader,
            showAnimation: true,
            actionText: 'Chưa có sản phẩm nào',
            onActionPressed: () => Get.to(() => const NavigatorMenu()),
          );
        }

        return SingleChildScrollView(
            child:
                Padding(padding: const EdgeInsets.all(12), child: TCartItem()));
      }),
      bottomNavigationBar: Obx(
        () => cartController.cartItems.isEmpty
            ? const SizedBox()
            : SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const CheckoutScreen()),
                  child: Text(
                      'Checkout \$${cartController.totalPrice.value.toStringAsFixed(1)}'),
                ),
              ),
      ),
    );
  }
}
