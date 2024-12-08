import 'package:flutter/material.dart';

class ProductTitle extends StatelessWidget {
  const ProductTitle(
      {super.key,
      required this.title,
      this.maxLine = 2,
      this.isSmallSize = false,
      this.textAlign = TextAlign.left});

  final String title;
  final int maxLine;
  final bool isSmallSize;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    // final dark = TheplerFunction.isDarkMode(context);
    return Text(title,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLine,
        style: isSmallSize
            ? Theme.of(context).textTheme.labelLarge
            // .apply(color: dark ? Colors.white : Colors.black)
            : Theme.of(context).textTheme.titleSmall
        // .apply(color: dark ? Colors.white : Colors.black),
        );
  }
}
