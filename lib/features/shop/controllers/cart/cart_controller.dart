import 'package:app1/common/widgets/loaders/loader.dart';
import 'package:app1/features/shop/models/cart_item_model.dart';
import 'package:app1/ultis/local_storage/storage_utilly.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../ultis/constants/enum.dart';
import '../../models/product_model.dart';
import '../products/variation_controller.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxInt noOfItems = 0.obs;
  RxDouble totalPrice = 0.0.obs;
  RxInt productQuantity = 0.obs;

  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instace;

  CartController() {
    loadItemsCart();
    loadCart();
  }

  void addToCart(ProductModel product) {
    if (productQuantity.value < 1) {
      Get.snackbar('Lỗi', 'Sản phẩm cần lớn hơn 0');
      return;
    }
    if (product.productType == ProductType.variable.name &&
        variationController.selectedAttributes.isEmpty) {
      Get.snackbar('Lỗi', 'Vui lòng chọn sản phẩm');
      return;
    }
    if (product.productType == ProductType.variable.name) {
      if (variationController.selectedVariation.value.stock < 1) {
        Get.snackbar('Lỗi', 'Sản phẩm đã hết hàng');
        return;
      } else {
        if (product.stock < 1) {
          Get.snackbar('Lỗi', 'Sản phẩm hết hàng');
          return;
        }
      }
      final selectedItem =
          convertProductToCartItem(product, productQuantity.value);
      int index = cartItems
          .indexWhere((item) => item.productId == selectedItem.productId);
      if (index != -1) {
        cartItems[index] = selectedItem;
      } else {
        cartItems.add(selectedItem);
      }
    }
    updateCart();
    TLoader.showLoadingToast("Đã thêm vào giỏ hàng");
  }

  CartItemModel convertProductToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.name) {
      variationController.resetSelectedAttributes();
    }
    final variation = variationController.selectedVariation.value;
    if (kDebugMode) {
      print('variation: $variation');
    }
    // if (kDebugMode) {
    //   // print('DEBUG TẠI ĐÂY');
    //   // print(' name ${variation.price}');
    //   // print(' name ${variation.salePrice}');
    //   // print('Variation ID: ${variation.id}');
    //   // print('Variation Image: ${variation.image}');
    //   // print('Variation Attributes: ${variation.attributeValues}');
    // }

    final isVariable = variation.id.isNotEmpty;
    if (kDebugMode) {
      print('isVariable: $isVariable');
    }
    final price = product.productType == ProductType.variable.name
        ? variation.salePrice > 0.0
            ? variation.salePrice
            : variation.price
        : product.salePrice > 0.0
            ? product.salePrice
            : product.price;

    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: price,
      quantity: quantity,
      variationId: variation.id,
      image: product.thumbnail,
      brandName: product.brand?.name ?? '',
      selectedAttributes: isVariable ? variation.attributeValues : null,
    );
  }

  void updateCart() {
    updateTotalPrice();
    saveCart();
    cartItems.refresh();
  }

  void updateTotalPrice() {
    double calculatedPrice = 0.0;
    int calculatedNoOfItems = 0;
    for (var item in cartItems) {
      calculatedPrice += item.price * item.quantity;
      calculatedNoOfItems += item.quantity;
    }
    totalPrice.value = calculatedPrice;
    noOfItems.value = calculatedNoOfItems;
    TLocalStorage.instance().saveData('noOfItems', noOfItems.value);
    TLocalStorage.instance().saveData('totalPrice', totalPrice.value);
  }

  void loadItemsCart() {
    noOfItems.value = TLocalStorage.instance().readData<int>('noOfItems') ?? 0;
    totalPrice.value =
        TLocalStorage.instance().readData<double>('totalPrice') ?? 0;
  }

  void saveCart() {
    final cartItemString =
        cartItems.map((element) => element.toJson()).toList();
    TLocalStorage.instance().saveData('cartItems', cartItemString);
  }

  void loadCart() {
    final cartItemString =
        TLocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemString != null) {
      cartItems.assignAll(cartItemString.map((element) =>
          CartItemModel.fromJson(element as Map<String, dynamic>)));
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItems = cartItems
        .where(
          (item) => item.productId == productId,
        )
        .fold(
          0,
          (previousValue, element) => previousValue + element.quantity,
        );
    return foundItems;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItems = cartItems.firstWhere(
      (element) =>
          element.productId == productId && element.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );
    return foundItems.quantity;
  }

  void clearCart() {
    cartItems.clear();
    TLocalStorage.instance().removeData('noOfItems');
    TLocalStorage.instance().removeData('totalPrice');
    updateCart();
  }

  void addOneItem(CartItemModel item) {
    int index = cartItems.indexWhere((element) =>
        element.productId == item.productId &&
        element.variationId == item.variationId);
    if (index >= 0) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneItem(CartItemModel item) {
    int index = cartItems.indexWhere((element) =>
        element.productId == item.productId &&
        element.variationId == item.variationId);
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
        title: 'Xóa sản phẩm',
        middleText: 'Bạn có chắc chắn muốn xóa sản phẩm ra khỏi giỏ hàng?',
        onConfirm: () {
          cartItems.removeAt(index);
          updateCart();
          TLoader.successMessage('Xóa thành công');
          Get.back();
        },
        onCancel: () {
          Get.back();
        });
  }

  void updateAlreadyAddProductCount(ProductModel product) {
    if (product.productType == ProductType.single.name) {
      productQuantity.value = getProductQuantityInCart(product.id);
    } else {
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantity.value =
            getVariationQuantityInCart(product.id, variationId);
      } else {
        productQuantity.value = 0;
      }
    }
  }
}
