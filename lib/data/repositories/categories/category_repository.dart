import 'package:app1/data/services/firebase_service/firebase_storage_service/firebase_storage_service.dart';
import 'package:app1/features/shop/models/category_model.dart';

import 'package:app1/ultis/exception/firebase_exception.dart';
import 'package:app1/ultis/exception/platform_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db
          .collection('Categories')
          .where('isFetured', isEqualTo: true)
          .get();
      final listCategory = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return listCategory;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw ' something went strong';
    }
  }

  //get sub categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    final snapshot = await _db
        .collection('Categories')
        .where('parentId', isEqualTo: categoryId)
        .get();
    final result = snapshot.docs
        .map(
          (e) => CategoryModel.fromSnapshot(e),
        )
        .toList();
    return result;
  }

  //upload image
  Future<void> uploadDumyData(List<CategoryModel> categories) async {
    try {
      final storage = Get.put(TFirebaseStorageService());
      for (var category in categories) {
        final file = await storage.getImageDataFromAsset(category.image);
        final url =
            await storage.uploadImageData('categories', file, category.name);
        category.image = url;
        //luu db len firebase
        await _db
            .collection('categories')
            .doc(category.id)
            .set(category.toMap());
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went strong. Please try again ${e.toString()}';
    }
  }
}
