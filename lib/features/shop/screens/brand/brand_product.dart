import 'package:app1/common/appbar/appbar.dart';
import 'package:app1/common/widgets/brands/t_band_cart.dart';
import 'package:app1/common/widgets/products/sorttable/sort_table.dart';
import 'package:app1/common/widgets/shimmers/category_shimmer.dart';
import 'package:app1/features/shop/controllers/brand/brand_controller.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../models/brand_model.dart';

class BrandProduct extends StatelessWidget {
  const BrandProduct({super.key, required this.brandModel});

  final BrandModel brandModel;
  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: const TAppBar(
        title: Text('brand'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TBandCart(
                showBorder: true,
                brandModel: BrandModel.empty(),
              ),
              const SizedBox(
                height: 24,
              ),
              FutureBuilder<List<ProductModel>>(
                  future:
                      brandController.getBrandProduct(brandId: brandModel.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: TCategoryShimmers(itemCount: 4));
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    }
                    final brandProduct = snapshot.data!;
                    return TSortTableProduct(productModel: brandProduct);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
