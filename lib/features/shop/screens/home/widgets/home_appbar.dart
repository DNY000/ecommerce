import 'package:app1/common/appbar/appbar.dart';
import 'package:app1/common/widgets/products/product_cart/cart_menu_item.dart';
import 'package:app1/common/widgets/shimmers/shimmer.dart';
import 'package:app1/ultis/constants/tcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../authentication/controller/user/user_controller.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    return TAppBar(
      action: const [
        CartMenuItem(
          iconColor: TColor.white,
        )
      ],
      title: Column(
        children: [
          Text(
            'Chào bạn',
            style: Theme.of(context).textTheme.labelMedium!.apply(
                  color: Colors.white,
                ),
          ),
          Obx(() {
            if (userController.isLoading.value) {
              return const TShimmerEffect(
                width: 100,
                height: 20,
              );
            }
            return Text(
              userController.user.value.fullName.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: Colors.white),
            );
          }),
        ],
      ),
    );
  }
}
