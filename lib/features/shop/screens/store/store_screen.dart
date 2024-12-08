import 'package:app1/common/appbar/appbar.dart';
import 'package:app1/common/appbar/tabbar.dart';
import 'package:app1/common/widgets/custom_shapes/container/search_container.dart';
import 'package:app1/common/widgets/layout/t_gird_product.dart';
import 'package:app1/common/widgets/products/product_cart/cart_menu_item.dart';
import 'package:app1/common/widgets/brands/t_band_cart.dart';
import 'package:app1/common/widgets/shimmers/category_shimmer.dart';
import 'package:app1/common/widgets/texts/selection_heading.dart';
import 'package:app1/features/shop/controllers/category/category_controller.dart';
import 'package:app1/features/shop/models/brand_model.dart';
import 'package:app1/features/shop/models/category_model.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:app1/features/shop/screens/brand/all_brand.dart';
import 'package:app1/features/shop/screens/brand/brand_product.dart';
import 'package:app1/features/shop/screens/store/categoty_card.dart';
import 'package:app1/ultis/constants/constants.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/brand/brand_controller.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen(
      {super.key,
      required this.categoryModel,
      required this.productModel,
      required this.brandModel});

  final CategoryModel categoryModel;
  final ProductModel productModel;
  final BrandModel brandModel;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance.allCategory;
    final brandController = Get.put(BrandController());
    return DefaultTabController(
      length: controller.length,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            'Cửa hàng',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          action: const [
            CartMenuItem(iconColor: Colors.black),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                centerTitle: true,
                floating: true, // Đặt thành false để giữ tab bar cố định
                pinned: true,
                // Giữ thanh tìm kiếm ở trên cùng
                expandedHeight: 350,
                backgroundColor: TheplerFunction.isDarkMode(context)
                    ? Color(0xFF2C2C2C)
                    : Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.all(TSizes.s),
                    child: Column(
                      children: [
                        const SizedBox(height: TSizes.defaulBtwItem),
                        TSearchContainer(
                          text: 'Tìm kiếm sản phẩm',
                          showBackground: true,
                        ),
                        const SizedBox(height: TSizes.defaulBtwItem),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: TSelectionHeading(
                            title: 'Thương hiệu nổi bật',
                            showActionButton: true,
                            onPressed: () {
                              Get.to(const AllBrandScreen(
                                productModel: [],
                              ));
                            },
                          ),
                        ),
                        const SizedBox(height: TSizes.defaulBtwItem),
                        Obx(
                          () {
                            if (brandController.isLoading.value) {
                              return const TCategoryShimmers(
                                itemCount: 4,
                              );
                            }
                            if (brandController.futuredBrand.isEmpty) {
                              return const Center(
                                  child: Text('Không tìm thấy thương hiệu'));
                            }
                            return TGirdProduct(
                              itemCount: brandController.futuredBrand.length,
                              mainAxisExtent: 40,
                              itemBuilder: (_, index) {
                                final brand =
                                    brandController.futuredBrand[index];
                                return TBandCart(
                                  onPressed: () =>
                                      Get.to(BrandProduct(brandModel: brand)),
                                  brandModel: brand,
                                );
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                bottom: TTabBar(
                    tabbar: controller
                        .map(
                          (categories) => Tab(
                            child: Text(categories.name),
                          ),
                        )
                        .toList()),
              ),
            ];
          },
          body: TabBarView(
              children: controller
                  .map((categories) => TCategotyCard(
                        categoryModel: categories,
                      ))
                  .toList()),
        ),
      ),
    );
  }
}
