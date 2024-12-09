import 'package:app1/features/shop/screens/product_reviews/widgets/rating_and_progress_Indicator.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';

class TProductRating extends StatelessWidget {
  const TProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = TheplerFunction.isDarkMode(context);
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '4.8',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .apply(color: dark ? Colors.white : Colors.black),
          ),
        ),
        const Expanded(
            flex: 7,
            child: Column(
              children: [
                TRatingLinearProgressIndicator(
                  value: 1,
                  text: '5',
                ),
                TRatingLinearProgressIndicator(
                  value: 0.8,
                  text: '4',
                ),
                TRatingLinearProgressIndicator(
                  value: 0.6,
                  text: '3',
                ),
                TRatingLinearProgressIndicator(
                  value: 0.4,
                  text: '2',
                ),
                TRatingLinearProgressIndicator(
                  value: 0.2,
                  text: '1',
                )
              ],
            ))
      ],
    );
  }
}
