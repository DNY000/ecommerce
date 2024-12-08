// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  String productId;
  int quantity;
  String title;
  double price;
  String? image;
  String variationId;
  String? brandName;
  Map<String, String>? selectedAttributes;
  CartItemModel({
    required this.productId,
    required this.quantity,
    this.title = '',
    this.price = 0.0,
    this.image,
    this.variationId = '',
    this.brandName,
    this.selectedAttributes,
  });
  static CartItemModel empty() => CartItemModel(
        productId: '',
        quantity: 0,
      );
  Map<String, dynamic> toJson() => {
        'productId': productId,
        'quantity': quantity,
        'title': title,
        'price': price,
        'image': image,
        'variationId': variationId,
        'brandName': brandName,
        'selectedAttributes': selectedAttributes,
      };
  static CartItemModel fromJson(Map<String, dynamic> json) => CartItemModel(
        productId: json['productId'] ?? '',
        quantity: json['quantity'] ?? 0,
        title: json['title'] ?? '',
        price: json['price'] ?? 0.0,
        image: json['image'] ?? '',
        variationId: json['variationId'] ?? '',
        brandName: json['brandName'] ?? '',
        selectedAttributes: json['selectedAttributes'] != null
            ? Map<String, String>.from(json['selectedAttributes'])
            : null,
      );
  factory CartItemModel.fromSnapshot(DocumentSnapshot snapshot) =>
      CartItemModel.fromJson(snapshot.data() as Map<String, dynamic>);
}
