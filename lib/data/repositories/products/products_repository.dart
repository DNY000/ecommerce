import 'package:app1/data/services/firebase_service/firebase_storage_service.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:app1/ultis/constants/enum.dart';
import 'package:app1/ultis/exception/firebase_exception.dart';
import 'package:app1/ultis/exception/platform_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductsRepository extends GetxController {
  static ProductsRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  Future<List<ProductModel>> allproducts() async {
    try {
      final snapshot = await _db.collection('Products').get();
      final listProducts = snapshot.docs
          .map(
            (e) => ProductModel.fromSnapshot(e),
          )
          .toList();

      return listProducts;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'some thing  $e';
    }
  }

  Future<List<ProductModel>> fetchProductquery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> listProducts = querySnapshot.docs
          .map((doc) => ProductModel.fromSnapshot(
              doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();

      return listProducts;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'some thing  $e';
    }
  }

  Future<List<ProductModel>> fetchAllProduct() async {
    try {
      final snapshot = await _db
          .collection('Products')
          // .where('IsFeatured', isEqualTo: true)
          .get();
      final listProducts = snapshot.docs
          .map(
            (e) => ProductModel.fromSnapshot(e),
          )
          .toList();

      return listProducts;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'some thing  $e';
    }
  }

  Future<List<ProductModel>> getProductForBrand(
      {required String brandId, int limit = -1}) async {
    try {
      final query = limit == -1
          ? await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .get()
          : await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandId)
              .limit(limit)
              .get();
      final listProducts = query.docs
          .map(
            (e) => ProductModel.fromSnapshot(e),
          )
          .toList();
      // for (var p in listProducts) {
      //   print('đay là categoty');
      //   print(p.category);
      // }
      return listProducts;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'some thing  $e';
    }
  }

  Future<List<ProductModel>> getProductForCategory(
      {required String categoryId, int limit = -1}) async {
    try {
      // Sửa lại query, sử dụng isEqualTo thay vì in
      final querySnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('Category',
                  isEqualTo:
                      categoryId) // Đảm bảo path này đúng với structure trong Firestore
              .get()
          : await _db
              .collection('Products')
              .where('Category', isEqualTo: categoryId)
              .limit(limit)
              .get();

      // print(
      //     "[DEBUG] Repository: Query returned ${querySnapshot.docs.length} documents");

      final listProducts =
          querySnapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();

      return listProducts;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Lỗi khi lấy sản phẩm: $e';
    }
  }

  Future<void> uploadDumyProduct(List<ProductModel> products) async {
    try {
      final storage = Get.put(TFirebaseStorageService());
      for (var product in products) {
        final thumnail = await storage.getImageDataFromAsset(product.thumbnail);
        final url = await storage.uploadImageData(
            'Products/Images', thumnail, product.thumbnail.toString());
        product.thumbnail = url;
        //product list of images
        if (product.image != null && product.image!.isEmpty) {
          List<String> iamgeUrl = [];
          for (var image in product.image!) {
            final assetImage = await storage.getImageDataFromAsset(image);
            final url = await storage.uploadImageData(
                "Products/Images", assetImage, image);
            iamgeUrl.add(url);
          }
          product.image!.clear();
          product.image!.addAll(iamgeUrl);

          if (product.productType == ProductType.variable.toString()) {
            for (var variation in product.productVariations!) {
              final assetImage =
                  await storage.getImageDataFromAsset(variation.image);
              final url = await storage.uploadImageData(
                  "Products/Images", assetImage, variation.image);
              variation.image = url;
            }
          }
        }
        await _db.collection('Products').doc(product.id).set(product.toJson());
      }
    } catch (e) {
      throw " $e";
    }
  }

  Future<List<ProductModel>> getFavouritesProduct(
      List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      final listProducts = snapshot.docs
          .map(
            (e) => ProductModel.fromSnapshot(e),
          )
          .toList();

      return listProducts;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'some thing  $e';
    }
  }

  Future<void> deleteProduct() async {
    try {
      // Lấy documents cần xóa
      final snapshot = await _db
          .collection('Products')
          .where('Brand.IsFeatured', isEqualTo: null)
          .get();

      if (snapshot.docs.isEmpty) {
        if (kDebugMode) {
          print('Không có sản phẩm nào để xóa');
        }
        return;
      }

      // Hiển thị số lư�ng documents sẽ xóa
      if (kDebugMode) {
        print('Tìm thấy ${snapshot.docs.length} sản phẩm để xóa');
      }

      // Tạo batch để xóa nhi�u documents
      final batch = _db.batch();

      // Thêm các operations xóa vào batch
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      // Thực hiện batch
      await batch.commit();

      // print('Đã xóa ${snapshot.docs.length} sản phẩm thành công');
    } catch (e) {
      // print('Lỗi khi xóa sản phẩm: $e');
      throw 'Có lỗi xảy ra khi xóa sản phẩm: $e';
    }
  }
}
