import 'package:app1/features/shop/models/brand_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  Future<List<BrandModel>> getAllBrands() async {
    final snapshot = await _db.collection('Brand').get();
    final listBrand = snapshot.docs
        .map(
          (e) => BrandModel.fromSnapshot(e),
        )
        .toList();
    return listBrand;
  }

  Future<List<BrandModel>> getBrandForCategory(String categoryId) async {
    try {
      // Trước tiên tìm trong collection BrandCategory
      final brandCategorySnapshot = await _db
          .collection('BrandCategory')
          .where('CategoryId', isEqualTo: categoryId)
          .get();

      // print(
      //     "[DEBUG] Số lượng brand-category relations: ${brandCategorySnapshot.docs.length}");

      // Lấy danh sách BrandIds
      final brandIds = brandCategorySnapshot.docs
          .map((doc) => doc['BrandId'] as String)
          .toList();
      if (brandIds.isEmpty) {
        // print("[DEBUG] Không tìm thấy brands cho category này");
        return [];
      }

      // Lấy thông tin brands từ collection Brand
      final brandsSnapshot = await _db
          .collection('Brand')
          .where(FieldPath.documentId, whereIn: brandIds)
          .get();

      // print("[DEBUG] Số lượng brands tìm thấy: ${brandsSnapshot.docs.length}");

      return brandsSnapshot.docs
          .map((doc) => BrandModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      // print("[DEBUG] Lỗi trong getBrandForCategory: ${e.toString()}");
      rethrow;
    }
  }
}
