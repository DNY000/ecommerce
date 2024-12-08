import 'package:app1/common/appbar/appbar.dart';
import 'package:app1/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:app1/common/widgets/snackbar/snackbar.dart';
import 'package:app1/common/widgets/texts/selection_heading.dart';
import 'package:app1/features/personalization/controller/address_controller.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:app1/ultis/price_calculator/price_calcutor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart/cart_controller.dart';
import '../../controllers/checkout/checkout_controller.dart';
import '../../controllers/order/order_controller.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subtotal = cartController.totalPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = TPricingCalculator.calculateFinalPrice(subtotal, 'VN');
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Thanh toán'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // TCartItem(
              //   item: CartItemModel.empty(),
              // ),
              Row(
                children: [
                  Flexible(
                      child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Nhập mã giảm giá',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none),
                    ),
                  )),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Áp dụng')),
                  )
                ],
              ),
              const TCircularContainer(
                radius: 20,
                isShowBorder: true,
                child: Column(
                  children: [
                    TBillingAmoutSection(),
                    Divider(),
                    TPaymentSection(),
                    TSelectedAddress()
                    // TSelectionHeading(
                    //   title: 'Shipping Address',
                    //   showActionButton: true,
                    //   buttonTitle: 'Change',
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Text('Nguyen Van Duy')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
            onPressed: subtotal > 0
                ? () => orderController.processOrder(totalAmount)
                : () => TSnackBar.showWarningSnackBar(
                    title: 'Giỏ hàng trống',
                    message: 'Thêm một sản phẩm để thanh toán'),
            child: Text('Thanh toán \$${totalAmount.toStringAsFixed(1)}')),
      ),
    );
  }
}

class TPaymentSection extends StatelessWidget {
  const TPaymentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = TheplerFunction.isDarkMode(context);
    final controller = Get.put(CheckoutController());
    return Column(
      // // mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TSelectionHeading(
          title: 'Phương thức thanh toán',
          buttonTitle: 'Thay đổi',
          showActionButton: true,
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        SizedBox(
          height: 20,
        ),
        Obx(
          () => Row(
            children: [
              TCircularContainer(
                width: 60,
                height: 35,
                background: dark ? Colors.white : Colors.black,
                padding: 10,
                child: Image(
                  image: AssetImage(
                    controller.selectedPaymentMethod.value.image,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Text(controller.selectedPaymentMethod.value.name)
            ],
          ),
        ),
      ],
    );
  }
}

class TBillingAmoutSection extends StatelessWidget {
  const TBillingAmoutSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final subtotal = controller.totalPrice.value;

    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tổng tiền sản phẩm'),
              Text('\$${subtotal.toStringAsFixed(1)}')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Phí vận chuyển'),
              Text(
                  '\$${TPricingCalculator.calculateShippingCost(subtotal, 'VN')}')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Phí thuế'),
              Text(
                  '\$${TPricingCalculator.calculateShippingCost(subtotal, 'VN')}')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tổng tiền'),
              Text(
                  '\$${TPricingCalculator.calculateFinalPrice(subtotal, 'VN').toStringAsFixed(1)}')
            ],
          ),
        ],
      ),
    );
  }
}

class TSelectedAddress extends StatelessWidget {
  const TSelectedAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSelectionHeading(
          title: "Địa chỉ giao hàng",
          buttonTitle: 'Thay đổi',
          showActionButton: true,
          onPressed: () => controller.selectedNewAddressPopup(context),
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () => controller.addressModel.value.id.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.addressModel.value.name),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(controller.addressModel.value.phoneNumber)
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_history,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Text(
                                controller.addressModel.value.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          )
                        ],
                      )
                    ],
                  ),
                )
              : Text('Chọn địa chỉ giao hàng'),
        )
      ],
    );
  }
}
