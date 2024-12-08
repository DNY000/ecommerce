import 'package:app1/data/repositories/authentication/authentication_repository.dart';
import 'package:get/get.dart';

import '../features/authentication/controller/network/network_manager.dart';
import '../features/shop/controllers/products/variation_controller.dart';
import '../features/shop/controllers/cart/cart_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(AuthenticationRepository());

    Get.put(VariationController());
    Get.put(CartController());
  }
}
