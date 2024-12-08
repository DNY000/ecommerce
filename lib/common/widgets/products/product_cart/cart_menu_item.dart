import 'package:app1/features/shop/controllers/cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../features/shop/screens/cart/cart.dart';

class CartMenuItem extends StatelessWidget {
  const CartMenuItem({super.key, required this.iconColor});

  final Color iconColor;
  // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return Stack(
      children: [
        IconButton(
            onPressed: () => Get.to(() => const CartScreen()),
            icon: const Icon(FontAwesomeIcons.bagShopping)),
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
                    cartController.noOfItems.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
