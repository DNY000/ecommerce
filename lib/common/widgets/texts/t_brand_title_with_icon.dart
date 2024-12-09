import 'package:app1/common/widgets/texts/text_brand_title.dart';
import 'package:app1/ultis/constants/constants.dart';
import 'package:app1/ultis/constants/enum.dart';
import 'package:flutter/material.dart';

class TBrandTitleWithIcon extends StatelessWidget {
  const TBrandTitleWithIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor = Colors.black,
    this.iconColors = Colors.black,
    this.brandTextSize = TextSizes.small,
    this.textAlign = TextAlign.center,
  });
  final String title;
  final int maxLines;
  final Color? textColor, iconColors;
  final TextSizes brandTextSize;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextBrandTitle(
            title: title,
            textColor: textColor!,
            textAlign: textAlign,
            maxLines: maxLines,
            textSizes: brandTextSize,
          ),
        ),
        const SizedBox(
          width: TSizes.m,
        ),
        const Icon(
          Icons.done,
          size: 12,
        )
      ],
    );
  }
}
