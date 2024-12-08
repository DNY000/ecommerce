import 'package:app1/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:app1/common/widgets/icons/t_circular_icon.dart';
import 'package:app1/common/widgets/images/t_rouded_image.dart';
import 'package:app1/common/widgets/products/ratings/ratingbar_progress_indicator.dart';
import 'package:app1/common/widgets/texts/product_title.dart';
import 'package:app1/ultis/constants/images_string.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';

class TUserReviewsCard extends StatelessWidget {
  const TUserReviewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  child: TRounderImage(
                    image: TImages.dongHo4,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Nguyen van Duy',
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            TCircularIcon(
              onPressed: () {},
              iconColor: Colors.black,
              icon: const Icon(FontAwesomeIcons.ellipsisVertical),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const TRatingBarProgessIndicator(
              rating: 4.5,
              sizeStar: 10,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              '01, Now, 2023',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: Colors.black54),
            )
          ],
        ),
        const ReadMoreText(
          'The user interface of the app is quite intutive. I was able to navigate and make purchaese good job',
          trimLines: 4,
          trimMode: TrimMode.Line,
          trimCollapsedText: "More than",
          trimExpandedText: "less",
          moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 20,
        ),
        TCircularContainer(
          background: TheplerFunction.isDarkMode(context)
              ? Colors.grey.shade800
              : Colors.grey.shade200,
          padding: 20,
          radius: 10,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ProductTitle(
                    title: 'Duy store',
                  ),
                  Text(
                    '02, Now, 2023',
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
              const ReadMoreText(
                'The user interface of the app is quite intutive. I was able to navigate and make purchaese good job The user interface of the app is quite intutive. I was able to navigate and make purchaese good job The user interface of the app is quite intutive. I was able to navigate and make purchaese good job',
                trimLines: 4,
                trimMode: TrimMode.Line,
                trimCollapsedText: "More than",
                trimExpandedText: "less",
                moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        )
      ],
    );
  }
}
