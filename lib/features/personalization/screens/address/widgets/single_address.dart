import 'package:app1/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:app1/features/personalization/controller/address_controller.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../models/address_model.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({
    super.key,
    required this.address,
    required this.onTap,
  });

  final AddressModel address;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final dark = TheplerFunction.isDarkMode(context);
    final controller = AddressController.instance;
    return Obx(() {
      final selectedAddressId = controller.addressModel.value.id;
      final selectedAddress = selectedAddressId == address.id;

      return InkWell(
        onTap: onTap,
        child: TCircularContainer(
          isShowBorder: true,
          colorBorder: selectedAddress
              ? Colors.transparent
              : dark
                  ? Colors.grey.shade400
                  : Colors.grey.shade800,
          background: selectedAddress
              ? Colors.blue.shade50.withOpacity(0.4)
              : Colors.transparent,
          // height: 80,
          radius: 20,
          margin: 16,
          padding: 10,
          child: Stack(
            children: [
              Positioned(
                  right: 0,
                  top: 0,
                  child: Icon(
                    selectedAddress ? FontAwesomeIcons.circleCheck : null,
                    color: selectedAddress
                        ? dark
                            ? Colors.grey.shade200
                            : Colors.grey.shade800
                        : null,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(address.name),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(address.phoneNumber),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    address.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
