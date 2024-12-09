import 'package:app1/common/widgets/custom_shapes/container/search_container.dart';
import 'package:app1/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:app1/common/widgets/layout/t_gird_product.dart';
import 'package:app1/common/widgets/products/product_cart/custom_list_cart.dart';
import 'package:app1/common/widgets/texts/selection_heading.dart';
import 'package:app1/features/shop/controllers/products/product_controller.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:app1/features/shop/screens/all_product/all_product.dart';
import 'package:app1/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:app1/features/shop/screens/home/widgets/home_category.dart';
import 'package:app1/features/shop/screens/home/widgets/promo_banner.dart';
import 'package:app1/ultis/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/shimmers/product_shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.productModel});

  final ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
    final controllerProduct = Get.put(ProductController());
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const TPrimaryHeaderContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //app bar
                HomeAppBar(),
                SizedBox(
                  height: TSizes.defaulBtwItem,
                ),
                //search
                TSearchContainer(
                  text: 'Tìm kiếm sản phẩm ',
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: TSizes.defaultSpace,
                    top: TSizes.defaultSpace,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TSelectionHeading(
                        title: 'Danh mục sản phẩm',
                        showActionButton: false,
                      ),
                      SizedBox(
                        height: TSizes.defaulBtwItem,
                      ),
                      THomeCategory(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // ... existing code ...
          TSelectionHeading(
            title: 'Sản phẩm nổi bật',
            showActionButton: true,
            onPressed: () {
              // print('Bắt đầu fetch products'); // Thêm log
              final future = controllerProduct.fetchAllProducts();
              future.then((products) {
                // print('Số lượng sản phẩm: ${products.length}'); // Thêm log
              }).catchError((error) {
                // print('Lỗi khi fetch products: $error'); // Thêm log
              });
              Get.to(AllProductScreen(
                title: 'Tất cả ',
                futureMethod: future,
              ));
            },
          ),
// ... existing code ...
          const SizedBox(
            height: 20,
          ),
          const TPromoSlider(),
          Obx(
            () {
              if (controllerProduct.isLoading.value) {
                return TGirdViewShimmers(
                    itemCount: controllerProduct.featuredProduct.length,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.25);
              } else if (controllerProduct.featuredProduct.isEmpty) {
                return const Center(
                  child: Text('Không có dữ liệu'),
                );
              }

              return TGirdProduct(
                itemCount: controllerProduct.featuredProduct.length,
                mainAxisExtent: 270,
                itemBuilder: (_, index) => CustomListCart(
                  products: controllerProduct.featuredProduct[index],
                ),
              );
            },
          )
        ],
      ),
    ));
  }
}
