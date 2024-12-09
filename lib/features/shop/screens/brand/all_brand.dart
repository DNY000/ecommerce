import 'package:app1/common/appbar/appbar.dart';
import 'package:app1/common/widgets/brands/t_band_cart.dart';
import 'package:app1/common/widgets/layout/t_gird_product.dart';
import 'package:app1/common/widgets/shimmers/category_shimmer.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:app1/features/shop/screens/brand/brand_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/brand/brand_controller.dart';

class AllBrandScreen extends StatelessWidget {
  const AllBrandScreen({super.key, required this.productModel});
  final List<ProductModel> productModel;
  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: const TAppBar(
        title: Text('All Brand'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Brand'),
            Obx(
              () {
                if (brandController.isLoading.value) {
                  return const TCategoryShimmers(
                    itemCount: 4,
                  );
                }
                if (brandController.allBrand.isEmpty) {
                  return const Center(child: Text('No brand found'));
                }
                return TGirdProduct(
                  itemCount: brandController.allBrand.length,
                  mainAxisExtent: 60,
                  itemBuilder: (_, index) {
                    final brand = brandController.allBrand[index];
                    return TBandCart(
                      brandModel: brand,
                      onPressed: () => Get.to(BrandProduct(brandModel: brand)),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
