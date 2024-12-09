import 'package:app1/common/widgets/brands/brand_show_case.dart';
import 'package:app1/common/widgets/shimmers/category_shimmer.dart';
import 'package:app1/features/shop/controllers/brand/brand_controller.dart';
import 'package:app1/features/shop/models/category_model.dart';
import 'package:flutter/widgets.dart';

class CategoryBrand extends StatelessWidget {
  const CategoryBrand({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandForCategory(categoryModel.id),
        builder: (context, snapshot) {
          //   print("[DEBUG] snapshot: ${categoryModel.id}");
          if (!snapshot.hasData) return const TCategoryShimmers(itemCount: 4);
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          final brands = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              return FutureBuilder(
                future: controller.getBrandProduct(brandId: brand.id, limit: 1),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const TCategoryShimmers(itemCount: 3);
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(' no data'),
                    );
                  }
                  final products = snapshot.data!;
                  return TBandShowCase(
                      listImage: products.map((e) => e.thumbnail).toList(),
                      brandModel: brand);
                },
              );
            },
          );
        });
  }
}
