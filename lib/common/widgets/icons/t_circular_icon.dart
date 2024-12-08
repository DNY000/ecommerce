import 'package:app1/ultis/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TCircularIcon extends StatelessWidget {
  const TCircularIcon(
      {super.key,
      required this.onPressed,
      this.icon = const Icon(FontAwesomeIcons.heart),
      this.height,
      this.width,
      this.size = TSizes.iconM,
      this.backgroundColor = Colors.transparent,
      required this.iconColor});

  final VoidCallback onPressed;
  final double? height, width, size;
  final Color backgroundColor;
  final Color iconColor;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration:
            BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
        child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon.icon,
              size: size,
              color: iconColor,
            )));
  }
}
