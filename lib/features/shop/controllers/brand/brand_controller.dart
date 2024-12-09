import 'package:app1/data/repositories/brand/brand_repository.dart';
import 'package:app1/data/repositories/products/products_repository.dart';
import 'package:app1/features/shop/models/brand_model.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();
  final brandRepository = Get.put(BrandRepository());
  final RxList<BrandModel> allBrand = <BrandModel>[].obs;
  final RxList<BrandModel> futuredBrand = <BrandModel>[].obs;
  final isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();

    getFuturedBrand();
  }

  Future<void> getFuturedBrand() async {
    try {
      isLoading.value = true;
      final brands = await brandRepository.getAllBrands();
      allBrand.assignAll(brands);
      futuredBrand.assignAll(allBrand.take(4));
    } catch (e) {
      // ignore: avoid_print
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> getBrandProduct(
      {required String brandId, int limit = -1}) async {
    try {
      final products = await ProductsRepository.instance
          .getProductForBrand(brandId: brandId, limit: limit);
      return products;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return [];
    }
  }

  Future<List<BrandModel>> getBrandForCategory(String categoryId) async {
    try {
      // Kiểm tra categoryId
      if (categoryId.isEmpty) {
        return [];
      }

      final brands =
          await BrandRepository.instance.getBrandForCategory(categoryId);
      // print("[DEBUG] Tìm thấy ${brands.length} brands");
      return brands;
    } catch (e) {
      // print("[DEBUG] Lỗi: ${e.toString()}");
      return [];
    }
  }
}
