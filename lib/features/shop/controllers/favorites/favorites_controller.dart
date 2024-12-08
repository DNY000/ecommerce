import 'dart:convert';

import 'package:app1/data/repositories/products/products_repository.dart';
import 'package:app1/ultis/local_storage/storage_utilly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/loaders/loader.dart';
import '../../models/product_model.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();
  final favorites = <String, bool>{}.obs;
  @override
  void onInit() {
    initFavorites();
    super.onInit();
  }

  Future<void> initFavorites() async {
    final json = TLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storeFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storeFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavorite(String productId) {
    return favorites[productId] ?? false;
  }

  void toggleFavorite(String productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavorites();
      TLoader.showCustomToast(
          message: 'Đã thêm vào yêu thích', gravity: ToastGravity.BOTTOM);
    } else {
      TLocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavorites();
      favorites.refresh();
      TLoader.showCustomToast(
          message: 'Đã xóa khỏi yêu thích', gravity: ToastGravity.BOTTOM);
    }
  }

  void saveFavorites() {
    final encodeFavorites = jsonEncode(favorites);
    TLocalStorage.instance().saveData('favorites', encodeFavorites);
  }

  Future<List<ProductModel>> getFavouritesProduct() async {
    return ProductsRepository.instance
        .getFavouritesProduct(favorites.keys.toList());
  }
}
