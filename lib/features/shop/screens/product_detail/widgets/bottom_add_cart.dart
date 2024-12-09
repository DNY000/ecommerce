import 'package:app1/common/widgets/icons/t_circular_icon.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../controllers/cart/cart_controller.dart';
import '../../../models/product_model.dart';

class TBottomAddCart extends StatelessWidget {
  const TBottomAddCart({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateAlreadyAddProductCount(product);
    final bool dark = TheplerFunction.isDarkMode(context);
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: dark ? Colors.grey.shade600 : Colors.grey.shade100,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TCircularIcon(
                  onPressed: () => controller.productQuantity.value < 1
                      ? null
                      : controller.productQuantity.value -= 1,
                  icon: const Icon(FontAwesomeIcons.minus),
                  iconColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  controller.productQuantity.value.toString(),
                  style: TextStyle(
                      color: const Color.fromRGBO(0, 0, 0, 1), fontSize: 14),
                ),
                const SizedBox(
                  width: 10,
                ),
                TCircularIcon(
                  icon: const Icon(FontAwesomeIcons.plus),
                  iconColor: Colors.black,
                  backgroundColor: Colors.white,
                  onPressed: () => controller.productQuantity.value += 1,
                ),
              ],
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size(80, 50)),
                onPressed: controller.productQuantity.value < 1
                    ? null
                    : () => controller.addToCart(product),
                child: const Text(
                  "Add to card",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
