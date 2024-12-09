import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app1/features/shop/models/order_model.dart';

import '../authentication/authentication_repository.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get order related to current User
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.userAuth!.uid;
      // if (kDebugMode) {
      //   print('Fetching orders for user: $userId');
      // }
      if (userId.isEmpty) {
        throw 'Không tìm thấy thông tin người dùng. Vui lòng thử lại sau vài phút.';
      }

      final result =
          await _db.collection('Users').doc(userId).collection('Orders').get();
      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Loi $e';
    }
  }

  // Store new user order
  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .add(order.toJson());
    } catch (e) {
      throw 'Something went wrong while saving Order Information. Try again later.';
    }
  }
}
