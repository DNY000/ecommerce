import 'package:app1/ultis/constants/enum.dart';
import 'package:flutter/material.dart';

class TextBrandTitle extends StatelessWidget {
  const TextBrandTitle(
      {super.key,
      required this.title,
      this.maxLines = 1,
      this.textColor = Colors.black,
      this.textAlign = TextAlign.center,
      this.textSizes = TextSizes.small});

  final String title;
  final int maxLines;
  final Color textColor;
  final TextAlign? textAlign;
  final TextSizes textSizes;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: TextOverflow.ellipsis,
        style: textSizes == TextSizes.small
            ? Theme.of(context).textTheme.labelSmall!.apply(color: textColor)
            : textSizes == TextSizes.medium
                ? Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: textColor)
                : textSizes == TextSizes.large
                    ? Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .apply(color: textColor)
                    : Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: textColor));
  }
}
