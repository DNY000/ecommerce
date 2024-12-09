import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:app1/common/appbar/appbar.dart';
import 'package:app1/common/widgets/products/sorttable/sort_table.dart';
import 'package:app1/common/widgets/shimmers/category_shimmer.dart';
import 'package:app1/features/shop/controllers/products/all_product_controller.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:get/get.dart';

import '../../controllers/products/product_controller.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;
  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    final controller = Get.put(AllProductController());
    return Scaffold(
      appBar: TAppBar(
        title: Text(title),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductquery(query),
            builder: (context, snapshot) {
              const loader = TCategoryShimmers(itemCount: 6);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loader;
              }
              if (!snapshot.hasData ||
                  snapshot.data == null ||
                  snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No Data Found'),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              final products = snapshot.data!;
              return TSortTableProduct(productModel: products);
            }),
      ),
    );
  }
}
