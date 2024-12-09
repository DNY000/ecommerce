// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app1/features/shop/models/brand_model.dart';
import 'package:app1/features/shop/models/product_attribute_model.dart';
import 'package:app1/features/shop/models/product_variation_model.dart';

class ProductModel {
  String id;
  String? sku;
  String title;
  int stock;
  double price;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? descriptions;
  String? category;
  String productType;
  List<String>? image;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    this.sku,
    required this.title,
    required this.stock,
    this.price = 0.0,
    this.date,
    this.salePrice = 0.0,
    required this.thumbnail,
    this.isFeatured,
    this.brand,
    this.descriptions,
    this.category,
    required this.productType,
    this.image,
    this.productAttributes,
    this.productVariations,
  });

  static ProductModel empty() => ProductModel(
        id: "",
        salePrice: 0,
        price: 0,
        title: "",
        stock: 1,
        thumbnail: "",
        productType: "single",
      );

  // Convert the ProductModel to a map for easier serialization (use Map for nested models)
  toJson() {
    return {
      'Id': id,
      'Sku': sku,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Date': DateTime.now(),
      'SalePrice': salePrice,
      'Thumbnail': thumbnail,
      'Featured': isFeatured,
      'Brand': brand!.toJson(), // Convert BrandModel to map
      'Descriptions': descriptions,
      'Category': category,
      'ProductType': productType,
      'Image': image,
      'ProductAttributes': productAttributes != null
          ? productAttributes!
              .map((x) => x.toJson())
              .toList() // Convert ProductAttributeModel list to map
          : [],
      'ProductVariations': productVariations != null
          ? productVariations!
              .map((x) => x.toJson())
              .toList() // Convert ProductVariationModel list to map
          : [],
    };
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      sku: data['Sku'] ?? '',
      title: data['Title'] ?? "xin chao",
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      category: data['Category'] ?? '',
      descriptions: data['Descriptions'] ?? "",
      thumbnail: data['Thumbnail'] ?? "",
      productType: data['ProductType'] ?? "",
      brand: BrandModel.fromJson(data["Brand"]),
      image: data['Image'] != null ? List<String>.from(data['Image']) : [],
      productAttributes: (data['ProductAttributes'] as List?)
              ?.map((e) => ProductAttributeModel.fromJson(e))
              .toList() ??
          [],
      productVariations: (data['ProductVariations'] as List?)
              ?.map((e) => ProductVariationModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
