import 'package:app1/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:app1/features/shop/models/payment_method_model.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../controllers/checkout/checkout_controller.dart';

class TPaymentTile extends StatelessWidget {
  const TPaymentTile({super.key, required this.paymentMethods});
  final PaymentMethodModel paymentMethods;
  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(15),
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethods;
        Get.back();
      },
      leading: TCircularContainer(
        width: 60,
        height: 40,
        background:
            TheplerFunction.isDarkMode(context) ? Colors.white : Colors.black,
        padding: 12,
        child: Image(
          image: AssetImage(paymentMethods.image),
          fit: BoxFit.cover,
        ),
      ),
      title: Text(paymentMethods.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
