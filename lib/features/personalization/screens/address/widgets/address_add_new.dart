import 'package:app1/common/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../../ultis/validators/validation.dart';
import '../../../controller/address_controller.dart';

class AddNewAddress extends GetView<AddressController> {
  const AddNewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Add new Address'),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) =>
                      TValidation.nameValidator('Name', value),
                  controller: controller.name,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.user),
                      labelText: "Name"),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  validator: (value) => TValidation.phoneValidator(value ?? ''),
                  controller: controller.numberPhone,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.mobile),
                      labelText: "Number Phone"),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      validator: (value) =>
                          TValidation.nameValidator('Street', value),
                      controller: controller.street,
                      decoration: const InputDecoration(
                          labelText: "Street",
                          prefixIcon: Icon(FontAwesomeIcons.building)),
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: TextFormField(
                      validator: (value) =>
                          TValidation.nameValidator('Postal Code', value),
                      controller: controller.postalCode,
                      decoration: const InputDecoration(
                          labelText: "Postal Code",
                          prefixIcon: Icon(FontAwesomeIcons.code)),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      validator: (value) =>
                          TValidation.nameValidator('City', value),
                      controller: controller.city,
                      decoration: const InputDecoration(
                          labelText: "City",
                          prefixIcon: Icon(FontAwesomeIcons.city)),
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: controller.state,
                      decoration: const InputDecoration(
                          labelText: "State",
                          prefixIcon: Icon(FontAwesomeIcons.accusoft)),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) =>
                      TValidation.nameValidator('Country', value),
                  controller: controller.country,
                  decoration: const InputDecoration(
                      labelText: 'Contry',
                      prefixIcon: Icon(FontAwesomeIcons.globe)),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.addAddress,
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
