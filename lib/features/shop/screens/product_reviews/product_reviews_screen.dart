import 'package:app1/common/appbar/appbar.dart';
import 'package:app1/common/widgets/products/ratings/ratingbar_progress_indicator.dart';
import 'package:app1/features/shop/screens/product_reviews/widgets/product_rating.dart';
import 'package:app1/features/shop/screens/product_reviews/widgets/user_reviews_card.dart';
import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = TheplerFunction.isDarkMode(context);
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Review & Rating'),
        showBackArrow: true,
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rating and reviews are verified and are from people  who use the same type of divice that you use   ',
                style: TextStyle(color: dark ? Colors.white : Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              const TProductRating(),
              const TRatingBarProgessIndicator(
                sizeStar: 15,
                rating: 4,
              ),
              Text(
                '12.3223',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 40,
              ),
              // user reviews
              const TUserReviewsCard(),
              const SizedBox(
                height: 20,
              ),
              const TUserReviewsCard(),
              const SizedBox(
                height: 20,
              ),
              const TUserReviewsCard(),
              const SizedBox(
                height: 20,
              ),
              const TUserReviewsCard(),
              const SizedBox(
                height: 20,
              ),
              const TUserReviewsCard(),
              const SizedBox(
                height: 20,
              ),
              const TUserReviewsCard(),
            ],
          ),
        ),
      ),
    );
  }
}
