// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class BrandCategoryModel {
  final String brandId;
  final String categoryId;
  BrandCategoryModel({
    required this.brandId,
    required this.categoryId,
  });
  // static BrandCategoryModel empty() =>
  //     BrandCategoryModel(brandId: '', categoryId: "");

  Map<String, dynamic> toJson() {
    return {'BrandId': brandId, 'CategoryId': categoryId};
  }

  factory BrandCategoryModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BrandCategoryModel(
        brandId: data['BrandId'] as String,
        categoryId: data['CategoryId'] as String);
  }
}
