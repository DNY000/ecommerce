import 'package:app1/common/widgets/layout/t_gird_product.dart';
import 'package:app1/common/widgets/products/product_cart/custom_list_cart.dart';
import 'package:app1/common/widgets/shimmers/category_shimmer.dart';
import 'package:app1/common/widgets/texts/selection_heading.dart';
import 'package:app1/features/shop/controllers/category/category_controller.dart';
import 'package:app1/features/shop/models/category_model.dart';
import 'package:app1/features/shop/screens/all_product/all_product.dart';
import 'package:app1/features/shop/screens/brand/category_brand.dart';
import 'package:app1/ultis/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TCategotyCard extends StatelessWidget {
  const TCategotyCard({
    super.key,
    required this.categoryModel,
  });

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    //  final brandController = BrandController.instance;
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CategoryBrand(categoryModel: categoryModel),
            FutureBuilder(
              future:
                  controller.getCategoryProduct(categoryId: categoryModel.id),
              builder: (context, snapshot) {
                //   print("[DEBUG] Builder state: ${snapshot.connectionState}");
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const TCategoryShimmers(itemCount: 5);
                }
                if (!snapshot.hasData) {
                  // print("[DEBUG] No data state");
                  return const Center(
                    child: Text('Không có dữ liệu'),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                final product = snapshot.data!;

                return Column(
                  children: [
                    TSelectionHeading(
                      title: 'Bạn có thể thích',
                      showActionButton: true,
                      onPressed: () {
                        Get.to(
                          AllProductScreen(
                            title: categoryModel.name,
                            futureMethod: controller.getCategoryProduct(
                                categoryId: categoryModel.id, limit: -1),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: TSizes.defaulBtwItem,
                    ),
                    TGirdProduct(
                      mainAxisExtent: 265,
                      itemCount: product.length,
                      itemBuilder: (_, index) => CustomListCart(
                        products: product[index],
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
