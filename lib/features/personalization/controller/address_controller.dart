import 'package:app1/common/widgets/texts/selection_heading.dart';
import 'package:app1/features/personalization/screens/address/widgets/address_add_new.dart';
import 'package:app1/features/personalization/screens/address/widgets/single_address.dart';
import 'package:app1/ultis/constants/images_string.dart';
import 'package:app1/common/widgets/poppup/full_screen_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/snackbar/snackbar.dart';
import '../../../data/repositories/address/address_repository.dart';
import '../models/address_model.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();
  RxBool refreshData = true.obs;
  final AddressRepository addressRepository = Get.put(AddressRepository());
  final Rx<AddressModel> addressModel = AddressModel.empty.obs;
  final TextEditingController name = TextEditingController();
  final TextEditingController numberPhone = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController postalCode = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController country = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchAddress();
  }

  Future<List<AddressModel>> fetchAddress() async {
    try {
      final result = await addressRepository.fetchAddress();
      addressModel.value = result.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> selectAddress(AddressModel newSelectedAddress) async {
    try {
      if (addressModel.value.id.isNotEmpty) {
        await addressRepository.updateAddressField(
            addressModel.value.id, false);
      }
      await addressRepository.updateAddressField(newSelectedAddress.id, true);
      newSelectedAddress.selectedAddress = true;
      addressModel.value = newSelectedAddress;
      refreshData.toggle();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addAddress() async {
    try {
      TFullScreenLoader.openLoadingDialog('Đang thêm', TImages.animationLoader);
      if (formKey.currentState!.validate()) {
        final address = AddressModel(
            id: "",
            name: name.text.trim(),
            phoneNumber: numberPhone.text.trim(),
            street: street.text.trim(),
            postalCode: postalCode.text.trim(),
            city: city.text.trim(),
            state: state.text.trim(),
            country: country.text.trim(),
            selectedAddress: false,
            dateTime: DateTime.now());
        final newId = await addressRepository.addAddress(address);
        if (kDebugMode) {
          print("ID mới nhận được: $newId");
        }
        address.id = newId;
        await selectAddress(address);
        TFullScreenLoader.closeLoadingDialog();
        TSnackBar.showSuccessSnackBar('Thêm địa chỉ thành công',
            title: '', message: '');
        refreshData.toggle();
        resetFormField();
        Get.back();
      }
      TFullScreenLoader.closeLoadingDialog();
    } catch (e) {
      TFullScreenLoader.closeLoadingDialog();
      throw Exception(e);
    }
  }

  Future<dynamic> selectedNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TSelectionHeading(
                title: 'Selected address',
                showActionButton: false,
              ),
              FutureBuilder(
                future: fetchAddress(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('Không có dữ liệu'),
                    );
                  }
                  final address = snapshot.data!;
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => TSingleAddress(
                            address: address[index],
                            onTap: () async {
                              await selectAddress(snapshot.data![index]);
                              Get.back();
                            },
                          ));
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const AddNewAddress()),
                  child: Text('Thêm địa chỉ mới '),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void resetFormField() {
    name.clear();
    numberPhone.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
  }
}
