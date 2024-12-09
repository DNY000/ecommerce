import 'package:app1/features/shop/models/banner_model.dart';
import 'package:app1/ultis/exception/firebase_exception.dart';
import 'package:app1/ultis/exception/platform_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<BannerModel>> fetchBanner() async {
    try {
      final result = await _db
          .collection('Banners')
          .where('active',
              isEqualTo: true) // Sử dụng isEqualTo thay vì arrayContains
          .get();
      return result.docs
          .map(
            (banner) => BannerModel.fromSnapshot(banner),
          )
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again. Error: $e";
    }
  }
}
