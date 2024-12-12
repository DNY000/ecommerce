import 'package:app1/data/repositories/authentication/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/notification_model.dart';
import '../../../ultis/exception/firebase_exception.dart';
import '../../../ultis/exception/platform_exception.dart';

class NotificationRepository extends GetxController {
  static NotificationRepository get instance => Get.find();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveNotification(NotificationModel notification) async {
    try {
      await firestore
          .collection('Notifications')
          .doc(notification.id)
          .collection('Notifications')
          .doc()
          .set(notification.toJson());
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<NotificationModel>> fetchNotifications() async {
    try {
      final id = AuthenticationRepository.instance.userAuth!.uid;
      final snapshot = await firestore
          .collection('Notifications')
          .doc(id)
          .collection('Notifications')
          .get();
      final listNotification = snapshot.docs
          .map((document) => NotificationModel.fromSnapshot(document))
          .toList();
      return listNotification;
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> getCountUnread() async {
    final id = AuthenticationRepository.instance.userAuth!.uid;
    final snapshot = await firestore
        .collection('Notifications')
        .doc(id)
        .collection('Notifications')
        .where('isRead', isEqualTo: false)
        .get();
    return snapshot.docs.length;
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      final userId = AuthenticationRepository.instance.userAuth!.uid;

      final querySnapshot = await firestore
          .collection('Notifications')
          .doc(userId)
          .collection('Notifications')
          .get();

      // Tìm document cần update
      final docToUpdate = querySnapshot.docs.firstWhere(
        (doc) => doc.id == notificationId,
        orElse: () => throw Exception('Không tìm thấy thông báo'),
      );

      // Cập nhật isRead
      await docToUpdate.reference.update({'isRead': true});
    } catch (e) {
      throw Exception('Không thể cập nhật trạng thái thông báo: $e');
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      final id = AuthenticationRepository.instance.userAuth!.uid;
      await firestore
          .collection('Notifications')
          .doc(id)
          .collection('Notifications')
          .doc(notificationId)
          .delete();
    } on TFirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TPlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw Exception('Không thể xóa thông báo: $e');
    }
  }
}
