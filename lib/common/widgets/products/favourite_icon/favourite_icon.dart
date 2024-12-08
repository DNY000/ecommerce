import 'package:app1/common/widgets/icons/t_circular_icon.dart';
// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/favorites/favorites_controller.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(
      () => TCircularIcon(
        height: 32,
        width: 32,
        backgroundColor: Colors.grey.withOpacity(0.3),
        iconColor: controller.isFavorite(productId)
            ? Color.fromARGB(255, 207, 46, 34)
            : Colors.white,
        icon: Icon(
            size: 16,
            controller.isFavorite(productId) ? Iconsax.heart5 : Iconsax.heart),
        onPressed: () => controller.toggleFavorite(productId),
      ),
    );
  }
}
