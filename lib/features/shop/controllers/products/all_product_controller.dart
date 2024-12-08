import 'package:app1/data/repositories/products/products_repository.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AllProductController extends GetxController {
  static AllProductController get instane => Get.find();
  final repository = ProductsRepository.instance;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxString sortBy = 'Name'.obs;
  Future<List<ProductModel>> fetchProductquery(Query? query) async {
    try {
      if (query == null) return [];
      final listProducts =
          await ProductsRepository.instance.fetchProductquery(query);
      return listProducts;
    } catch (e) {
      return [];
    }
  }

  void sortProduct(String sortOption) {
    sortBy.value = sortOption;
    switch (sortOption) {
      case 'Name':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Higher Price':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Lower Price':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Newest':
        products.sort((a, b) => b.date!.compareTo(a.date!));
        break;
      case 'Sale':
        products.sort((a, b) {
          if (b.salePrice > 0) {
            return b.salePrice.compareTo(a.salePrice);
          } else if (a.salePrice > 0) {
            return -1;
          }
          return 1;
        });
        break;
      default:
        products.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  void assignProducts(List<ProductModel> products) {
    this.products.value = products;
    sortProduct("Name");
  }
}
