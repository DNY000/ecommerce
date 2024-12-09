import 'package:app1/common/styles/shadows.dart';
import 'package:app1/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:app1/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:app1/common/widgets/texts/product_price.dart';
import 'package:app1/common/widgets/texts/t_brand_title_with_icon.dart';
import 'package:app1/features/shop/controllers/products/product_controller.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:app1/features/shop/screens/product_detail/widgets/product_detail.dart';
import 'package:app1/ultis/constants/enum.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:app1/ultis/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/shop/controllers/cart/cart_controller.dart';

class CustomListCart extends StatelessWidget {
  const CustomListCart({super.key, required this.products});

  final ProductModel products;

  @override
  Widget build(BuildContext context) {
    final dark = TheplerFunction.isDarkMode(context);
    final controller = ProductController.instance;
    final salePrice =
        controller.calculateSalePercentage(products.price, products.salePrice);
    return InkWell(
      onTap: () {
        Get.to((ProductDetail(
          productModel: products,
        )));
      },
      child: Container(
        width: 180,
        // padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
            boxShadow: [TShadowStyle.verticalProductShadow],
            borderRadius: const BorderRadius.all(
                Radius.circular(TSizes.productImageRadius)),
            color: dark ? Colors.white : Color(0xFBF3F4F5)),
        constraints: BoxConstraints(
          maxWidth: 180,
          maxHeight: double.infinity,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TCircularContainer(
              radius: 0,
              height: 160,
              padding: 0,
              background: dark ? Colors.grey : Colors.white,
              child: Stack(
                children: [
                  SizedBox(
                    height: 160,
                    child: Image(
                      image: AssetImage(products.thumbnail),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      left: TSizes.defaultSpace / 3,
                      top: TSizes.defaultSpace / 3.5,
                      right: 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TCircularContainer(
                            width: 30,
                            height: 30,
                            background: Colors.amber,
                            radius: TSizes.borderRaidusl,
                            child: Center(
                                child: Text(
                              "$salePrice%",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .apply(
                                      color:
                                          dark ? Colors.black : Colors.white),
                            )),
                          ),
                          FavouriteIcon(productId: products.id)
                        ],
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.defaulBtwItem / 2,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.defaulBtwItem),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    products.title,
                    style: TextStyle(color: Colors.black),
                  ),
                  TBrandTitleWithIcon(
                    title: products.brand!.name,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Column(
                        children: [
                          if (products.productType == ProductType.single.name &&
                              products.salePrice > 0)
                            Text(
                              products.price.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .apply(
                                      decorationColor: Colors.black,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.red),
                            ),
                          TProductPrice(
                            price: controller.getPriceProduct(products),
                            isLarge: false,
                            lineThrough: false,
                          )
                        ],
                      )),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Stack(
                          children: [
                            Positioned(
                                right: 0,
                                bottom: 0,
                                child: TProductCartButton(product: products))
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TProductCartButton extends StatelessWidget {
  const TProductCartButton({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = TheplerFunction.isDarkMode(context);
    final cartController = CartController.instance;
    return InkWell(
      onTap: () {
        if (product.productType == ProductType.single.name) {
          final cartItems = cartController.convertProductToCartItem(product, 1);
          cartController.addOneItem(cartItems);
        } else {}
      },
      child: Obx(
        () {
          final productInCart =
              cartController.getProductQuantityInCart(product.id);
          return Container(
            decoration: BoxDecoration(
              color: productInCart > 0 ? Colors.grey.shade300 : Colors.grey,
              borderRadius: BorderRadius.circular(30),
            ),
            child: SizedBox(
              width: 30,
              height: 30,
              child: Center(
                child: productInCart > 0
                    ? Text(productInCart.toString())
                    : Icon(
                        Icons.add,
                        color: dark ? Colors.black : Colors.white,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
