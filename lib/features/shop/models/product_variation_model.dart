import 'package:flutter/foundation.dart';

class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = "",
    this.image = "",
    this.description,
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
  });

  static ProductVariationModel empty() =>
      ProductVariationModel(id: "", attributeValues: {});

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Sku': sku,
      'Image': image,
      'Description': description,
      'Price': price,
      'SalePrice': salePrice,
      'Stock': stock,
      'AttributeValues': attributeValues,
    };
  }

  factory ProductVariationModel.fromJson(Map<String, dynamic> data) {
    // debugPrint('=== Parsing ProductVariation ===');
    // debugPrint('Raw data: $data');

    if (data.isEmpty) return ProductVariationModel.empty();

    try {
      // Convert AttributeValues từ dynamic sang Map<String, String>
      Map<String, String> attributeValues = {};
      if (data['AttributeValues'] != null) {
        (data['AttributeValues'] as Map<String, dynamic>).forEach((key, value) {
          attributeValues[key] = value.toString();
        });
      }

      return ProductVariationModel(
        id: data['Id'] ?? '',
        sku: data['Sku'] ?? '',
        image: data['Image'] ?? '',
        description: data['Description'],
        price: (data['Price'] is num)
            ? (data['Price'] as num).toDouble()
            : double.parse((data['Price'] ?? '0.0').toString()),
        salePrice: (data['SalePrice'] is num)
            ? (data['SalePrice'] as num).toDouble()
            : double.parse((data['SalePrice'] ?? '0.0').toString()),
        stock: data['Stock'] ?? 0,
        attributeValues: attributeValues,
      );
    } catch (e) {
      debugPrint(' Error parsing ProductVariation: $e');
      return ProductVariationModel.empty();
    }
  }

  @override
  String toString() {
    return 'ProductVariation(id: $id, sku: $sku, attributeValues: $attributeValues)';
  }
}
