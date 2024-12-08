import 'package:app1/data/repositories/categories/category_repository.dart';
import 'package:app1/data/repositories/products/products_repository.dart';
import 'package:app1/features/shop/models/category_model.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
  //lay data
  final isLoading = false.obs;
  final selectIndex = 0.obs;

  final _categotyRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategory = <CategoryModel>[].obs;
  @override
  void onInit() {
    fetchCategory();
    super.onInit();
  }

  Future<void> fetchCategory() async {
    try {
      isLoading.value = true;
      final categories = await _categotyRepository.getAllCategories();
      allCategory.assignAll(
          categories.where((categorie) => categorie.isFetured).toList());
    } catch (e) {
      throw e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void updateIndex(index) {
    selectIndex.value = index;
  }

  Future<List<ProductModel>> getCategoryProduct(
      {required String categoryId, int limit = 4}) async {
    try {
      // print("[DEBUG] CategoryId in category controller: $categoryId");

      final products = await ProductsRepository.instance
          .getProductForCategory(categoryId: categoryId, limit: limit);

      // print("[DEBUG] Products received from repository: ${products.length}");
      return products;
    } catch (e) {
      //  print("[DEBUG] Error in getCategoryProduct: $e");
      rethrow; // Ném lại lỗi để FutureBuilder có thể bắt được
    }
  }

  ///
  ///
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final categories = await _categotyRepository.getSubCategories(categoryId);
      return categories;
    } catch (e) {
      //  print("[DEBUG] Error in getCategoryProduct: $e");
      rethrow; // Ném lại lỗi để FutureBuilder có thể bắt được
    }
  }
}
