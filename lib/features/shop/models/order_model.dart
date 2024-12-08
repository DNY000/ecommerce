import 'package:app1/features/personalization/models/address_model.dart';
import 'package:app1/features/shop/models/cart_item_model.dart';
import 'package:app1/ultis/constants/enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderState status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = 'Paypal',
    required this.address,
    this.deliveryDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'address': address.toJson(),
      'deliveryDate': deliveryDate,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    try {
      final data = snapshot.data() as Map<String, dynamic>;

      return OrderModel(
        id: snapshot.id,
        userId: data['userId']?.toString() ?? '',
        status: OrderState.values
            .firstWhere((e) => e.toString() == data['status']?.toString()),
        totalAmount: (data['totalAmount'] ?? 0.0).toDouble(),
        orderDate: data['orderDate'] != null
            ? (data['orderDate'] as Timestamp).toDate()
            : DateTime.now(),
        paymentMethod: data['paymentMethod']?.toString() ?? 'Paypal',
        address: data['address'] != null
            ? AddressModel.fromJson(data['address'] as Map<String, dynamic>)
            : AddressModel.empty,
        deliveryDate: data['deliveryDate'] != null
            ? (data['deliveryDate'] as Timestamp).toDate()
            : null,
        items: data['items'] != null
            ? (data['items'] as List<dynamic>)
                .map((itemData) =>
                    CartItemModel.fromJson(itemData as Map<String, dynamic>))
                .toList()
            : [],
      );
    } catch (e) {
      throw 'Lỗi khi xử lý thông tin đơn hàng: $e';
    }
  }
}
