import 'package:app1/common/widgets/chips/choose_chip.dart';
import 'package:app1/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:app1/common/widgets/texts/product_price.dart';
import 'package:app1/common/widgets/texts/product_title.dart';
import 'package:app1/common/widgets/texts/selection_heading.dart';
import 'package:app1/features/shop/controllers/products/variation_controller.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:app1/ultis/constants/constants.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TProductAttributed extends StatelessWidget {
  const TProductAttributed({super.key, required this.productModel});

  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());
    final dark = TheplerFunction.isDarkMode(context);
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.selectedVariation.value.id.isNotEmpty)
            TCircularContainer(
              height: 120,
              // width: double.infinity,
              background: dark ? Colors.grey.shade600 : Colors.grey.shade200,
              padding: 16,
              radius: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const ProductTitle(
                        title: "Variation",
                        isSmallSize: true,
                      ),
                      const SizedBox(
                        width: TSizes.l,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const ProductTitle(title: "Price"),
                              const SizedBox(
                                width: TSizes.borderRaidusl,
                              ),
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                TProductPrice(
                                  price: controller.getVariationPrice(),
                                  isLarge: false,
                                  lineThrough: true,
                                  maxLine: 1,
                                ),
                              const SizedBox(
                                width: TSizes.borderRaidusl,
                              ),
                              TProductPrice(
                                  price: controller.getVariationPrice(),
                                  isLarge: true,
                                  lineThrough: false),
                            ],
                          ),
                          Row(
                            children: [
                              const ProductTitle(title: "Stock"),

                              const SizedBox(
                                width: TSizes.xxl,
                              ),
                              // ignore: avoid_print

                              ProductTitle(
                                title: controller.variationStockStatus.value,
                                isSmallSize: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  ProductTitle(
                    title: controller.selectedVariation.value.description ?? '',
                    isSmallSize: false,
                    maxLine: 4,
                  )
                ],
              ),
            ),
          // const TSelectionHeading(title: 'Colors'),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: productModel.productAttributes!.map(
              (attribute) {
                return Column(
                  children: [
                    TSelectionHeading(title: attribute.name ?? ''),
                    const SizedBox(
                      height: 30,
                    ),
                    Obx(
                      () => Wrap(
                          spacing: 6,
                          children: attribute.values!.map((attributesValue) {
                            final isSelected =
                                controller.selectedAttributes[attribute.name] ==
                                    attributesValue;
                            final available = controller
                                .getAttribuesAvaliblityInVariation(
                                    productModel.productVariations!,
                                    attribute.name!)
                                .contains(attributesValue);
                            return TChoiceChip(
                                text: attributesValue,
                                selected: isSelected,
                                onSelected: available
                                    ? (selected) {
                                        // Bỏ điều kiện isSelected vì nó ngăn việc chọn giá trị mới
                                        if (selected) {
                                          // debugPrint(
                                          //     '=== Selecting Attribute ==='); // Debug log
                                          // debugPrint(
                                          //     'Attribute: ${attribute.name}');
                                          // debugPrint('Value: $attributesValue');

                                          controller.onAttributesSeclected(
                                              productModel,
                                              attribute.name ?? '',
                                              attributesValue);
                                        }
                                      }
                                    : null);
                          }).toList()),
                    )
                  ],
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
