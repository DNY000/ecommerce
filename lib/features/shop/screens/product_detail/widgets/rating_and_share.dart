import 'package:app1/ultis/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TRatingAndShare extends StatelessWidget {
  const TRatingAndShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              FontAwesomeIcons.star,
              color: Colors.amber,
              size: 24,
            ),
            const SizedBox(
              width: TSizes.borderRadiusS,
            ),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: '5.0', style: Theme.of(context).textTheme.bodyLarge),
              const TextSpan(text: '(199)')
            ]))
          ],
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.shareNodes,
              size: TSizes.defaultSpace,
            ))
      ],
    );
  }
}
