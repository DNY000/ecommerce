import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TRatingBarProgessIndicator extends StatelessWidget {
  const TRatingBarProgessIndicator({
    super.key,
    required this.rating,
    required this.sizeStar,
  });
  final double rating;
  final double sizeStar;
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      unratedColor: Colors.grey,
      itemCount: 5,
      rating: rating,
      itemSize: sizeStar,
      itemPadding: const EdgeInsets.symmetric(horizontal: 5),
      itemBuilder: (_, __) => const Icon(
        FontAwesomeIcons.star,
        color: Colors.amber,
      ),
    );
  }
}
