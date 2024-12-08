import 'package:app1/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:app1/common/widgets/texts/text_brand_title.dart';
import 'package:app1/features/authentication/controller/user/user_controller.dart';
import 'package:app1/features/personalization/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProfileUserListTile extends StatelessWidget {
  const ProfileUserListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userController = UserController.instance;

    return Obx(() {
      return ListTile(
        leading: const TCircularContainer(
          height: 56,
          width: 56,
          background: Colors.white,
          child: Icon(FontAwesomeIcons.user),
        ),
        title: Text(
          userController.user.value.fullName,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .apply(color: Colors.white),
        ),
        subtitle: TextBrandTitle(
          textAlign: TextAlign.start,
          title: userController.user.value.email,
          textColor: Colors.white,
        ),
        trailing: IconButton(
            onPressed: () {
              Get.to(() => const ProfileScreen());
            },
            icon: const Icon(FontAwesomeIcons.penToSquare)),
      );
    });
  }
}
