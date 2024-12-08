import 'package:app1/common/widgets/layout/t_gird_product.dart';
import 'package:app1/common/widgets/products/product_cart/custom_list_cart.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../features/shop/controllers/products/all_product_controller.dart';

class TSortTableProduct extends StatelessWidget {
  const TSortTableProduct({
    super.key,
    required this.productModel,
  });
  final List<ProductModel> productModel;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
    controller.assignProducts(productModel);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          children: [
            DropdownButtonFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(FontAwesomeIcons.sort)),
              items: [
                'Name',
                'Higher Price',
                'Lower Price',
                'sale',
                'Newest',
                'Populary'
              ]
                  .map(
                    (options) => DropdownMenuItem(
                      value: options,
                      child: Text(options),
                    ),
                  )
                  .toList(),
              value: controller.sortBy.value,
              onChanged: (value) {
                controller.sortProduct(value!);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => TGirdProduct(
                  mainAxisExtent: 270,
                  itemCount: controller.products.length,
                  itemBuilder: (_, index) =>
                      CustomListCart(products: controller.products[index]),
                )),
          ],
        ),
      ),
    );
  }
}
