import 'package:app1/data/repositories/products/products_repository.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:app1/ultis/constants/enum.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  final isLoading = false.obs;
  final productRepositoty = Get.put(ProductsRepository());
  RxList<ProductModel> featuredProduct = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchProducts();
    fetchAllProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final products = await productRepositoty.allproducts();

      featuredProduct.assignAll(products);
    } catch (e) {
      // print('Error fetching products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      final products = await productRepositoty.fetchAllProduct();

      // products.forEach((product) {
      //   print('Product ID: ${product.id}');
      //   print('Product Name: ${product.title}');
      //   print('Product Price: ${product.price}');
      //   print('------------------------');
      // });

      return products;
    } catch (e) {
      //  print('Error fetching products: $e');
      return [];
    } finally {}
  }

  // Future<List<ProductModel>> getFavouritesProduct(List<String> productIds) async {
  //   try {
  //     final snapshot = await _

  //     // products.forEach((product) {
  //     //   print('Product ID: ${product.id}');
  //     //   print('Product Name: ${product.title}');
  //     //   print('Product Price: ${product.price}');
  //     //   print('------------------------');
  //     // });

  //     return products;
  //   } catch (e) {
  //     //  print('Error fetching products: $e');
  //     return [];
  //   } finally {}
  // }

// get price
  String getPriceProduct(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    if (product.productType == ProductType.single.name) {
      double priceToReturn =
          (product.salePrice > 0.0 ? product.salePrice : product.price);
      return priceToReturn.toString();
    } else {
      for (var variation in product.productVariations!) {
        double priceToConsider =
            variation.salePrice > 0 ? variation.salePrice : variation.price;
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }
      if (smallestPrice.isEqual(largestPrice)) {
        //  print(smallestPrice.isEqual(largestPrice));
        return largestPrice.toString();
      } else {
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }

  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;
    double percentage = ((originalPrice) - (salePrice)) / originalPrice * 100;
    return percentage.toStringAsFixed(0);
  }
  // get stock ;

  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock ' : "Out of Stock ";
  }

  Future<void> detectProductType() async {
    try {
      await productRepositoty.deleteProduct();
    } catch (e) {
      throw 'Error detecting product type: $e';
    }
  }
}
