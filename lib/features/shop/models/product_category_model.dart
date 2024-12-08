// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryModel {
  final String productId;
  final String categoryId;
  ProductCategoryModel({
    required this.productId,
    required this.categoryId,
  });
  Map<String, dynamic> toJson() => {
        'ProductId': productId,
        'CategoryId': categoryId,
      };
  // static ProductCategoryModel empty() =>
  //     ProductCategoryModel(productId: '', categoryId: '');
  factory ProductCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ProductCategoryModel(
        productId: data['ProductId'] as String,
        categoryId: data['CategoryId'] as String);
  }
}
