import 'package:get/get.dart';

import '../../models/payment_method_model.dart';

class TPaymentMethodController extends GetxController {
  static TPaymentMethodController instance = Get.find();
  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;
}
