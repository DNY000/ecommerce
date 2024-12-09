import 'package:app1/ultis/constants/images_string.dart';
import 'package:app1/ultis/device/device.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        // Text(
        //   'Welcome App ',
        //   style: Theme.of(context).textTheme.displaySmall,
        // ),
        Image(
          image: const AssetImage(TImages.logoappp),
          height: TDevice.getScreenHeight(context) * 0.13,
          width: TDevice.getScreenWidth(context) / 3,
        ),
        // Text(
        //   "Chao mung moi nguoi da den voi ",
        //   style: Theme.of(context).textTheme.labelLarge,
        // ),
      ],
    );
  }
}
