import 'package:app1/common/appbar/appbar.dart';
import 'package:app1/features/personalization/controller/address_controller.dart';
import 'package:app1/features/personalization/screens/address/widgets/address_add_new.dart';
import 'package:app1/features/personalization/screens/address/widgets/single_address.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddress()),
        backgroundColor: Colors.blue,
        child: const Icon(FontAwesomeIcons.plus, color: Colors.white),
      ),
      appBar: const TAppBar(
        title: Text('Địa chỉ'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Obx(
            () => FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
              future: controller.fetchAddress(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return const Center(child: Text("Không tìm thấy địa chỉ"));
                }

                final address = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: address.length,
                  itemBuilder: (context, index) {
                    return TSingleAddress(
                      address: address[index],
                      onTap: () => controller.selectAddress(address[index]),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
