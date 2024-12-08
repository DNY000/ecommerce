import 'package:app1/common/appbar/appbar.dart';
import 'package:app1/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:app1/common/widgets/list_tile/profile_user_list_tiletile.dart';
import 'package:app1/common/widgets/list_tile/setting_list_menu_item.dart';
import 'package:app1/common/widgets/texts/selection_heading.dart';
import 'package:app1/features/personalization/screens/address/widgets/address.dart';
import 'package:app1/features/shop/controllers/settings/setting_controller.dart';
import 'package:app1/features/shop/screens/order/order.dart';
import 'package:app1/ultis/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../shop/controllers/products/product_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingController());
    final productController = Get.put(ProductController());
    return SingleChildScrollView(
      child: Column(
        children: [
          TPrimaryHeaderContainer(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                children: [
                  TAppBar(
                    title: Text(
                      'Tài khoản',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: Colors.white),
                    ),
                  ),
                  const ProfileUserListTile()
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(TSizes.defaulBtwItem),
            child: Column(
              children: [
                const TSelectionHeading(
                  title: 'Cài đặt tài khoản',
                  textcolor: Colors.white,
                  showActionButton: false,
                ),
                SettingListMenuItem(
                  icon: FontAwesomeIcons.helmetSafety,
                  title: 'Địa chỉ ',
                  subtile: 'Thêm địa chỉ giao hàng tại đây',
                  onTap: () {
                    Get.to(const AddressScreen());
                  },
                ),
                // const Divider(),
                // SettingListMenuItem(
                //   icon: FontAwesomeIcons.helmetSafety,
                //   title: 'My address',
                //   subtile: 'Set shopping deivery address ',
                //   onTap: () {},
                // ),
                const Divider(),
                SettingListMenuItem(
                  icon: FontAwesomeIcons.jediOrder,
                  title: 'Đơn hàng của tôi',
                  subtile: 'Thêm đơn hàng tại đây',
                  onTap: () {
                    Get.to(const OrderSreen());
                  },
                ),
                const Divider(),
                SettingListMenuItem(
                  icon: FontAwesomeIcons.helmetSafety,
                  title: 'Xóa sản phẩm',
                  subtile: 'Xóa sản phẩm tại đây',
                  onTap: () {
                    productController.detectProductType();
                  },
                ),
                const Divider(),
                SettingListMenuItem(
                  icon: FontAwesomeIcons.brandsFontAwesome,
                  title: 'Thêm thương hiệu',
                  subtile: 'Thêm thương hiệu tại đây',
                  onTap: () {
                    controller.addBrand();
                  },
                ),
                const Divider(),
                SettingListMenuItem(
                  icon: FontAwesomeIcons.helmetSafety,
                  title: 'Thêm sản phẩm',
                  subtile: 'Thêm sản phẩm tại đây',
                  onTap: () {
                    controller.addMultipleProducts();
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () {
                        AuthenticationRepository.instance.logout();
                      },
                      child: const Text('Đăng xuất')),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
