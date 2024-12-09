// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFetured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = '',
    required this.isFetured,
  });

  // Phương thức tĩnh để tạo một instance mặc định của CategoryModel
  static CategoryModel empty() => CategoryModel(
        id: '',
        name: '',
        image: '',
        isFetured: false,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'parentId': parentId,
      'isFetured': isFetured,
    };
  }

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      return CategoryModel(
        id: document.id,
        name: data['name'] ?? '',
        image: data['image'] ?? '',
        parentId: data['parentId'] ?? '',
        isFetured: data['isFetured'] ?? false,
      );
    } else {
      // Trả về một instance mặc định nếu không có dữ liệu
      return CategoryModel.empty();
    }
  }
}
