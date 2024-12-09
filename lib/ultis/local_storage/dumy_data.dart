import 'package:app1/features/shop/models/brand_model.dart';
import 'package:app1/features/shop/models/category_model.dart';
import 'package:app1/features/shop/models/product_attribute_model.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:app1/features/shop/models/product_variation_model.dart';

import '../constants/images_string.dart';

class TDumyData {
  static final List<CategoryModel> categories = [
    CategoryModel(
      id: '1',
      name: 'Điện thoại',
      image: TImages.adidas1,
      isFetured: true,
    ),
    CategoryModel(
      id: '2',
      name: 'Đồng hồ',
      image: TImages.adidas1,
      isFetured: true,
    ),
    CategoryModel(
      id: '3',
      name: 'Áo',
      image: TImages.adidas1,
      isFetured: true,
    ),
    CategoryModel(
      id: '4',
      name: 'Giày',
      image: TImages.adidas1,
      isFetured: true,
    ),
  ];
  static final List<ProductModel> products = [
    // Existing products...

    ProductModel(
      id: '001',
      date: DateTime.now(),
      sku: 'SKU001',
      title: 'Samsung Galaxy S23',
      stock: 50,
      price: 999,
      salePrice: 449,
      thumbnail: TImages.ss1,
      isFeatured: true,
      brand: BrandModel(
          id: '1',
          name: 'Samsung',
          image: TImages.ss4,
          isFeatured: true,
          productsCount: 50),
      descriptions: 'Samsung Galaxy S23 with cutting-edge technology.',
      category: '1',
      productType: 'variable',
      image: [TImages.ss1, TImages.ss2, TImages.ss3, TImages.ss4],
      productAttributes: [
        ProductAttributeModel(
            name: 'Color', values: ['Black', 'White', 'Blue']),
        ProductAttributeModel(
            name: 'Storage', values: ['128GB', '256GB', '512GB']),
      ],
      productVariations: [
        ProductVariationModel(
          id: 'v001',
          sku: 'SKU001-128GB-BLACK',
          image: TImages.ss3,
          price: 400,
          salePrice: 399,
          description: 'Samsung Galaxy S23 với công nghệ mới nhất.',
          stock: 25,
          attributeValues: {'Color': 'Black', 'Storage': '128GB'},
        ),
        ProductVariationModel(
          id: 'v002',
          sku: 'SKU001-256GB-BLACK',
          image: TImages.ss3,
          price: 440,
          salePrice: 400,
          stock: 25,
          attributeValues: {'Color': 'Black', 'Storage': '256GB'},
        ),
        ProductVariationModel(
          id: 'v003',
          sku: 'SKU001-512GB-BLUE',
          image: TImages.ss3,
          price: 999,
          salePrice: 449,
          stock: 25,
          attributeValues: {'Color': 'BLue', 'Storage': '512GB'},
        ),
      ],
    ),
    ProductModel(
      id: '002',
      sku: 'SKU002',
      title: 'Sam sung s21 ultra',
      stock: 100,
      price: 1099,
      salePrice: 999,
      thumbnail: TImages.ss4,
      isFeatured: true,
      brand: BrandModel(
          id: '1',
          name: 'SamSung',
          image: TImages.ss1,
          isFeatured: true,
          productsCount: 50),
      descriptions: 'Samsung s21 ultra với công nghệ mới nhất.',
      category: '1',
      productType: 'variable',
      image: [TImages.ss1, TImages.ss3, TImages.ss4],
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Red', 'Black', 'White']),
        ProductAttributeModel(
            name: 'Storage', values: ['128GB', '256GB', '512GB']),
      ],
      productVariations: [
        ProductVariationModel(
          id: 'v004',
          sku: 'SKU002-128GB-RED',
          image: TImages.ss3,
          price: 888,
          salePrice: 880,
          stock: 30,
          attributeValues: {'Color': 'Red', 'Storage': '128GB'},
        ),
        ProductVariationModel(
          id: 'v005',
          sku: 'SKU002-256GB-BLACK',
          image: TImages.ss4,
          price: 900,
          salePrice: 889,
          stock: 35,
          attributeValues: {'Color': 'Black', 'Storage': '256GB'},
        ),
        ProductVariationModel(
          id: 'v006',
          sku: 'SKU002-512GB-RED',
          image: TImages.ss4,
          price: 999,
          salePrice: 900,
          stock: 35,
          attributeValues: {'Color': 'Red', 'Storage': '512GB'},
        ),
      ],
    ),
    // New Product 2: Nike Air Max
    ProductModel(
      id: '003',
      sku: 'SKU003',
      title: 'Nike Air Max',
      stock: 200,
      price: 149,
      salePrice: 129,
      thumbnail: TImages.nike6,
      isFeatured: true,
      brand: BrandModel(
          id: '2',
          name: 'Nike',
          image: TImages.nike8,
          isFeatured: true,
          productsCount: 50),
      descriptions: 'Nike Air Max là giày đế cao với chất liệu cao cấp.',
      category: '2',
      productType: 'variable',
      image: [TImages.nike8, TImages.nike7, TImages.nike3],
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['38', '39', '40', '41']),
        ProductAttributeModel(name: 'Color', values: ['Black', 'White']),
      ],
      productVariations: [
        ProductVariationModel(
          id: 'v007',
          sku: 'SKU003-8-BLACK',
          image: TImages.adidas4,
          price: 149,
          salePrice: 129,
          stock: 50,
          attributeValues: {'Size': '38', 'Color': 'Black'},
        ),
        ProductVariationModel(
          id: 'v008',
          sku: 'SKU003-9-WHITE',
          image: TImages.adidas4,
          price: 111,
          salePrice: 109,
          stock: 50,
          attributeValues: {'Size': '39', 'Color': 'White'},
        ),
      ],
    ),
    // Nike Category
    ProductModel(
      id: '007',
      sku: 'SKU006',
      title: 'Giay Da',
      stock: 100,
      price: 159,
      salePrice: 139,
      thumbnail: TImages.giayDa16,
      isFeatured: true,
      brand: BrandModel(id: '2', name: 'Nike', image: TImages.giayDa2),
      descriptions: 'Nike Air Max 2021 với chất liệu cao cấp.',
      category: '2',
      productType: 'variable',
      image: [TImages.giayDa5, TImages.giayDa2],
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['8', '9', '10', '11']),
        ProductAttributeModel(name: 'Color', values: ['Black', 'White']),
      ],
      productVariations: [
        ProductVariationModel(
          id: 'v009',
          sku: 'SKU006-8-BLACK',
          image: TImages.adidas4,
          price: 159,
          salePrice: 139,
          stock: 50,
          description: 'Giày da với chất liệu cao cấp.',
          attributeValues: {'Size': '8', 'Color': 'Black'},
        ),
        ProductVariationModel(
          id: 'v010',
          sku: 'SKU006-9-WHITE',
          image: TImages.giayDa4,
          price: 159,
          salePrice: 139,
          stock: 50,
          attributeValues: {'Size': '9', 'Color': 'White'},
        ),
      ],
    ),
    // Clothes Category
    ProductModel(
      id: '008',
      sku: 'SKU007',
      title: 'Men\'s Casual Shirt',
      stock: 200,
      price: 49,
      salePrice: 39,
      thumbnail: TImages.aoKhoac4,
      isFeatured: true,
      brand: BrandModel(
          id: '4',
          name: 'Clothes',
          image: TImages.aoKhoac7,
          isFeatured: true,
          productsCount: 510),
      descriptions: 'Áo khoác với chất liệu cao cấp.',
      category: '4',
      productType: 'single',
      image: [TImages.aoKhoac3, TImages.aoKhoac5],
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['S', 'M', 'L', 'XL']),
        ProductAttributeModel(name: 'Color', values: ['Blue', 'Green', 'Red']),
      ],
      productVariations: [
        ProductVariationModel(
          id: 'v011',
          description: 'Áo khoác với chất liệu cao cấp.',
          sku: 'SKU007-S-BLUE',
          image: TImages.aoKhoac6,
          price: 49.99,
          salePrice: 39.99,
          stock: 30,
          attributeValues: {'Size': 'S', 'Color': 'Blue'},
        ),
        ProductVariationModel(
          id: 'v012',
          sku: 'SKU007-M-GREEN',
          image: TImages.aoKhoac4,
          price: 49.99,
          salePrice: 39.99,
          stock: 30,
          attributeValues: {'Size': 'M', 'Color': 'Green'},
        ),
      ],
    ),
    // Điện thoại Category

    // Watch Category
    ProductModel(
      id: '010',
      sku: 'SKU009',
      title: 'Smart Watch Series 6',
      stock: 150,
      price: 399,
      salePrice: 349,
      thumbnail: TImages.dongHo1,
      isFeatured: true,
      brand: BrandModel(
          id: 'brand-watch',
          name: 'Watch',
          image: TImages.dongHo2,
          isFeatured: true,
          productsCount: 200),
      descriptions: 'Smart Watch Series 6 với chất liệu cao cấp.',
      category: '3',
      productType: 'single',
      image: [TImages.dongHo2, TImages.dongHo3],
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Black', 'Silver']),
      ],
      productVariations: [
        ProductVariationModel(
          id: 'v015',
          sku: 'SKU009-BLACK',
          image: TImages.dongHo4,
          price: 399.99,
          salePrice: 349.99,
          stock: 75,
          attributeValues: {'Color': 'Black'},
        ),
        ProductVariationModel(
          id: 'v016',
          sku: 'SKU009-SILVER',
          image: TImages.dongHo3,
          price: 399.99,
          salePrice: 349.99,
          stock: 75,
          attributeValues: {'Color': 'Silver'},
        ),
      ],
    ),
  ];

  static final List<BrandModel> brands = [
    BrandModel(id: '1', name: 'Samsung', image: TImages.ss1),
    BrandModel(id: '2', name: 'Apple', image: TImages.ss2),
    BrandModel(id: '3', name: 'Nike', image: TImages.nike2),
    BrandModel(id: '4', name: 'Quan ao', image: TImages.aoKhoac5),
    BrandModel(id: '5', name: 'Watch', image: TImages.dongHo2),
  ];
}
