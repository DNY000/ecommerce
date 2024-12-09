import 'package:app1/features/shop/controllers/products/image_product_controller.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:app1/features/shop/models/product_variation_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class VariationController extends GetxController {
  static VariationController get instace => Get.find();
  RxMap selectedAttributes = {}.obs;

  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;
//   ham chon thuoc tinh
  @override
  void onInit() {
    super.onInit();
    resetSelectedAttributes();
  }

  void onAttributesSeclected(
      ProductModel product, attributesName, attributesValue) {
    final selectedAttributes =
        Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributesName] = attributesValue;
    this.selectedAttributes[attributesName] = attributesValue;

    final selectVariation = product.productVariations!.firstWhere(
      (variation) =>
          _isSameAttribute(variation.attributeValues, selectedAttributes),
      orElse: () => ProductVariationModel.empty(),
    );

    debugPrint('=== Selected Variation Info ===');
    debugPrint('ID: ${selectVariation.id}');
    debugPrint('Price: ${selectVariation.price}');
    debugPrint('Sale Price: ${selectVariation.salePrice}');
    debugPrint('Stock: ${selectVariation.stock}');
    debugPrint('Attributes: ${selectVariation.attributeValues}');
    debugPrint('============================');

    if (selectVariation.image.isNotEmpty) {
      ImageProductController.instance.getCurrentIndex.value =
          selectVariation.image;
    }
    selectedVariation.value = selectVariation;
    getProductVariationStockStatus();
  }

  // check
  bool _isSameAttribute(Map<String, dynamic> variationAttributes,
      Map<String, dynamic> selectedAttributes) {
    // Kiểm tra nếu độ dài khác nhau
    // print((variationAttributes.length != selectedAttributes.length));
    if (variationAttributes.length != selectedAttributes.length) return false;

    // Kiểm tra xem selectedAttributes có chứa tất cả các key của variationAttributes không
    if (!variationAttributes.keys.every(selectedAttributes.containsKey)) {
      return false;
    }

    // So sánh giá trị
    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }

  // ham lay cac gia tri của variation
  Set<String?> getAttribuesAvaliblityInVariation(
      List<ProductVariationModel> variations, String attributesName) {
    final attributesAvaliblityInVariation = variations
        .where(
          (variation) =>
              variation.attributeValues[attributesName] != null &&
              variation.attributeValues[attributesName]!.isNotEmpty &&
              variation.stock > 0,
        )
        .map(
          (variation) => variation.attributeValues[attributesName],
        )
        .toSet();

    return attributesAvaliblityInVariation;
  }

  // ham lấy trạng thái stock
  void getProductVariationStockStatus() {
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? 'In Stock' : "Out of Stock";
  }

  //
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = "";
    selectedVariation.value = ProductVariationModel.empty();
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toString();
  }
}
