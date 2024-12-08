import 'package:app1/common/appbar/appbar.dart';
import 'package:app1/common/widgets/texts/selection_heading.dart';
import 'package:app1/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:app1/ultis/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../authentication/controller/user/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;
    final user = userController.user.value;

    // Hàm hiển thị preview ảnh

    // Hàm hiển thị bottom sheet chọn ảnh
    void showImagePickerOptions() {
      Get.bottomSheet(
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt, color: Colors.blue),
                title: Text('Chụp ảnh mới'),
                onTap: () async {
                  Get.back();
                  final imageUrl = await userController.uploadImageFromCamera();
                  if (imageUrl != null) {
                    if (userController.isLoading.value) {
                      Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      userController.saveSelectedImage();
                    }
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: Colors.green),
                title: Text('Chọn từ thư viện'),
                onTap: () async {
                  Get.back();
                  final imageUrl =
                      await userController.uploadImageFromGallery();
                  if (imageUrl != null) {
                    userController.saveSelectedImage();
                  }
                },
              ),
              if (userController.avatarUrl.value.isNotEmpty)
                ListTile(
                  leading: Icon(Icons.delete, color: Colors.red),
                  title: Text('Xóa ảnh đại diện'),
                  onTap: () {
                    Get.back();
                    Get.dialog(
                      AlertDialog(
                        title: Text('Xác nhận'),
                        content: Text('Bạn có muốn xóa ảnh đại diện không?'),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: Text('Hủy'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                              userController.clearAvatarUrl();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: Text('Xóa'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
      );
    }

    return Scaffold(
      appBar: const TAppBar(
        title: Text("Thông tin tài khoản"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Avatar with loading indicator
                    Stack(
                      children: [
                        Obx(() => Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[200],
                              ),
                              child: ClipOval(
                                child: userController.avatarUrl.value.isNotEmpty
                                    ? Image.network(
                                        userController.avatarUrl.value,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.grey,
                                        ),
                                      )
                                    : Icon(
                                        Icons.person,
                                        size: 60,
                                        color: Colors.grey,
                                      ),
                              ),
                            )),
                        if (userController.isLoading.value)
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: IconButton(
                                onPressed: () => showImagePickerOptions(),
                                icon: Icon(Icons.camera_alt)))
                      ],
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(
                height: TSizes.defaulBtwSelector,
              ),
              const Divider(),
              const TSelectionHeading(
                title: 'Thông tin tài khoản',
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.defaulBtwSelector,
              ),
              TProfileMenu(
                  onPressed: () {}, title: 'Họ tên', value: user.fullName),
              const SizedBox(
                height: TSizes.defaulBtwItem,
              ),
              TProfileMenu(
                  onPressed: () {},
                  title: 'Tên đăng nhập',
                  value: user.userName),
              const SizedBox(
                height: TSizes.defaulBtwItem,
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.defaultSpace,
              ),
              const TSelectionHeading(
                title: 'Thông tin cá nhân',
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.defaulBtwItem,
              ),
              TProfileMenu(
                onPressed: () {},
                title: 'Id người dùng',
                value: user.id,
                icon: FontAwesomeIcons.copy,
              ),
              const SizedBox(
                height: TSizes.defaulBtwItem,
              ),
              TProfileMenu(onPressed: () {}, title: 'Email', value: user.email),
              const SizedBox(
                height: TSizes.defaulBtwItem,
              ),
              TProfileMenu(
                  onPressed: () {},
                  title: 'Phone Number',
                  value: user.phoneNumber),
              const SizedBox(
                height: TSizes.defaulBtwItem,
              ),
              TProfileMenu(onPressed: () {}, title: 'Giới tính', value: 'Nam'),
              const SizedBox(
                height: TSizes.defaulBtwItem,
              ),
              TProfileMenu(
                  onPressed: () {},
                  title: 'Date of Birth',
                  value: '08/04/2003'),
              const SizedBox(
                height: TSizes.defaulBtwSelector * 1.5,
              ),
              Center(
                child: TextButton(
                    style:
                        TextButton.styleFrom(minimumSize: const Size(150, 50)),
                    onPressed: () {},
                    child: const Text('Đóng tài khoản')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
