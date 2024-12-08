import 'package:app1/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:app1/common/widgets/images/t_rouded_image.dart';
import 'package:app1/common/widgets/texts/t_brand_title_with_icon.dart';
import 'package:app1/common/widgets/texts/product_price.dart';
import 'package:app1/common/widgets/texts/product_title.dart';
import 'package:app1/features/shop/controllers/products/product_controller.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:app1/ultis/constants/constants.dart';
import 'package:app1/ultis/constants/enum.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData({super.key, required this.productModel});

  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    final dark = TheplerFunction.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(
        productModel.price, productModel.salePrice);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TCircularContainer(
              width: 50,
              height: 30,
              background: Colors.amber,
              radius: TSizes.borderRaidusl,
              child: Center(child: Text('$salePercentage%')),
            ),
            const SizedBox(
              width: TSizes.borderRaidusl,
            ),
            if (productModel.productType == ProductType.single.toString() &&
                productModel.salePrice > 0)
              TProductPrice(
                price: "\$${productModel.price}",
                lineThrough: true,
                isLarge: false,
              ),
            if (productModel.productType == ProductType.single.toString() &&
                productModel.salePrice > 0)
              const SizedBox(
                width: TSizes.borderRaidusl,
              ),
            TProductPrice(
              price: controller.getPriceProduct(productModel),
              lineThrough: false,
              isLarge: true,
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.xl,
        ),
        ProductTitle(
          title: productModel.title,
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: TSizes.xl,
        ),
        Row(children: [
          const ProductTitle(
            title: 'Status',
          ),
          const SizedBox(
            height: TSizes.xl,
          ),
          Text(
            controller.getProductStockStatus(productModel.stock),
            style: TextStyle(color: dark ? Colors.white : Colors.black),
          )
        ]),
        const SizedBox(
          height: TSizes.xl,
        ),
        Row(
          children: [
            TRounderImage(
              image:
                  productModel.brand != null ? productModel.brand!.image : "",
              height: 20,
              width: 20,
            ),
            const SizedBox(
              width: TSizes.xl,
            ),
            Expanded(
              child: TBrandTitleWithIcon(
                title:
                    productModel.brand != null ? productModel.brand!.name : '',
                brandTextSize: TextSizes.small,
                textColor: dark ? Colors.white : Colors.black,
                iconColors: dark ? Colors.white : Colors.black,
              ),
            )
          ],
        )
      ],
    );
  }
}
