import 'package:app1/common/widgets/products/product_cart/detail_items_cart.dart';
import 'package:app1/common/widgets/products/product_cart/quanity_with_price.dart';
import 'package:app1/common/widgets/texts/product_price.dart';
import 'package:app1/features/shop/controllers/cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
    this.showAddRemoveButton = true,
  });

  final bool showAddRemoveButton;
  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(() => ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.cartItems.length,
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (_, index) => Obx(
            () {
              final item = controller.cartItems[index];
              return Column(
                children: [
                  TDetailOnlyItemsCart(cartItem: item),
                  if (showAddRemoveButton)
                    const SizedBox(
                      height: 20,
                    ),
                  if (showAddRemoveButton)
                    Row(
                      children: [
                        TQuanityWithPrice(
                          quantity: item.quantity,
                          add: () => controller.addOneItem(item),
                          remove: () => controller.removeOneItem(item),
                        ),
                        TProductPrice(
                          price:
                              (item.price * item.quantity).toStringAsFixed(1),
                          isLarge: false,
                          lineThrough: false,
                        ),
                      ],
                    )
                ],
              );
            },
          ),
        ));
  }
}
