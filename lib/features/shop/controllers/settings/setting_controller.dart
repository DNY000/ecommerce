import 'package:app1/features/shop/models/brand_model.dart';
import 'package:app1/features/shop/models/product_model.dart';
import 'package:app1/ultis/local_storage/dumy_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  static SettingController get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  Future<void> addMultipleProducts() async {
    try {
      final CollectionReference productCollection = _db.collection('Products');

      WriteBatch batch = _db.batch();

      // Lặp qua danh sách sản phẩm trong TDumyData
      for (ProductModel product in TDumyData.products) {
        DocumentReference docRef =
            productCollection.doc(); // Tạo tài liệu mới với ID tự động
        batch.set(docRef,
            product.toJson()); // Thêm dữ liệu từ đối tượng product vào batch
      }

      // Cam kết (commit) tất cả các tác vụ trong batch
      await batch.commit();
      // print("5 products added successfully!");
    } catch (e) {
      //  print("Error adding products: $e");
      throw e.toString();
    }
  }

  void addBrand() async {
    try {
      final CollectionReference brandCollection = _db.collection('Brand');
      WriteBatch batch = _db.batch();
      for (BrandModel brand in TDumyData.brands) {
        DocumentReference docRef = brandCollection.doc();
        batch.set(docRef, brand.toJson());
      }
      await batch.commit();
      //  print('5 brands added successfully!');
    } catch (e) {
      //  print('Error adding brands: $e');
      throw e.toString();
    }
  }
}
