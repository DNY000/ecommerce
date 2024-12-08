import 'package:app1/common/appbar/appbar.dart';
import 'package:app1/common/widgets/texts/selection_heading.dart';
import 'package:app1/features/shop/models/category_model.dart';
import 'package:app1/features/shop/screens/all_product/all_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/products/product_cart/custom_list_cart.dart';
import '../../controllers/category/category_controller.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(category.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder(
              future: controller.getSubCategories(category.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return const Center(child: Text('No data found'));
                }
                final subCategories = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: subCategories.length,
                  itemBuilder: (context, index) {
                    final subCategory = subCategories[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: FutureBuilder(
                        future: controller.getCategoryProduct(
                            categoryId: subCategory.id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData) {
                            return const Center(child: Text('No data found'));
                          }
                          final products = snapshot.data!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TSelectionHeading(
                                title: subCategory.name,
                                onPressed: () => Get.to(() => AllProductScreen(
                                      title: subCategory.image,
                                      futureMethod:
                                          controller.getCategoryProduct(
                                              categoryId: category.id,
                                              limit: -1),
                                    )),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 300,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: products.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 10),
                                  itemBuilder: (context, index) =>
                                      CustomListCart(products: products[index]),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
