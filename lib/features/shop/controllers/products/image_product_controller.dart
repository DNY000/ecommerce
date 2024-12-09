import 'package:app1/features/shop/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageProductController extends GetxController {
  static ImageProductController get instance => Get.find();
  RxString getCurrentIndex = ''.obs;
  List<String> getAllImageProduct(ProductModel product) {
    Set<String> images = {};
    images.add(product.thumbnail);

    getCurrentIndex.value = product.thumbnail;
    if (product.image != null) {
      images.addAll(product.image!);
    }
    if (product.productVariations != null ||
        product.productVariations!.isNotEmpty) {
      images.addAll(product.productVariations!.map(
        (e) => e.image,
      ));
    }
    return images.toList();
  }

  void showElargedImage(String image) {
    Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: CachedNetworkImage(
                      imageUrl: image,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 150,
                      child: OutlinedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('close')),
                    ),
                  )
                ],
              ),
            ));
  }
}
