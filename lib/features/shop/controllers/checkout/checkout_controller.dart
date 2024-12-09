import 'package:app1/common/widgets/texts/selection_heading.dart';
import 'package:app1/features/shop/screens/checkout/payment_tile.dart';
import 'package:app1/ultis/constants/images_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/payment_method_model.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(name: "Paypal", image: TImages.adidas1);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const TSelectionHeading(
                title: 'Phương thức thanh toán',
                showActionButton: true,
              ),
              const SizedBox(
                height: 20,
              ),
              TPaymentTile(
                  paymentMethods:
                      PaymentMethodModel(name: 'Momo', image: TImages.momo)),
              const SizedBox(
                height: 10,
              ),
              TPaymentTile(
                  paymentMethods: PaymentMethodModel(
                      name: 'Banking', image: TImages.banking)),
              const SizedBox(
                height: 10,
              ),
              TPaymentTile(
                  paymentMethods: PaymentMethodModel(
                      name: 'Zalo Pay', image: TImages.zalopay)),
              const SizedBox(
                height: 10,
              ),
              TPaymentTile(
                  paymentMethods:
                      PaymentMethodModel(name: 'VNPay', image: TImages.vnpay)),
              const SizedBox(
                height: 10,
              ),
              TPaymentTile(
                  paymentMethods:
                      PaymentMethodModel(name: 'Visa', image: TImages.visa)),
            ],
          ),
        ),
      ),
    );
  }
}
