import 'package:app1/features/shop/controllers/cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../features/authentication/controller/notification/notification_controller.dart';
import '../../../../features/shop/screens/cart/cart.dart';
import '../../../../features/shop/screens/notification/notification.dart';

class CartMenuItem extends StatelessWidget {
  const CartMenuItem(
      {super.key,
      required this.iconColor,
      this.icon = FontAwesomeIcons.bagShopping,
      this.count,
      this.isNotification = false});

  final Color iconColor;
  final IconData? icon;
  final String? count;
  final bool isNotification;
  // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    final notificationController = Get.put(NotificationController());
    return Stack(
      children: [
        IconButton(
            onPressed: () => isNotification
                ? Get.to(() => const NotificationScreen())
                : Get.to(() => const CartScreen()),
            icon: Icon(icon, color: iconColor)),
        Positioned(
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Obx(
                  () => Text(
                    isNotification
                        ? notificationController.countUnread.toString()
                        : cartController.noOfItems.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
