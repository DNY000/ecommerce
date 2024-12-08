import 'package:app1/data/repositories/authentication/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../features/personalization/models/address_model.dart';

class AddressRepository extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<AddressModel>> fetchAddress() async {
    try {
      final userId = AuthenticationRepository.instance.userAuth!.uid;
      if (userId.isEmpty) {
        throw Exception('User ID is empty');
      }
      final result = await _firestore
          .collection("Users")
          .doc(userId)
          .collection("Address")
          .get();
      return result.docs
          .map(
            (e) => AddressModel.fromSnapshot(e),
          )
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.userAuth!.uid;
      final currentAddress = await _firestore
          .collection("Users")
          .doc(userId)
          .collection("Address")
          .add(address.toJson());
      await _firestore
          .collection("Users")
          .doc(userId)
          .collection("Address")
          .doc(currentAddress.id)
          .update({'id': currentAddress.id});

      return currentAddress.id;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateAddressField(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.userAuth!.uid;
      await _firestore
          .collection("Users")
          .doc(userId)
          .collection("Address")
          .doc(addressId)
          .update({"selectedAddress": selected});
    } catch (e) {
      throw Exception(e);
    }
  }
}
