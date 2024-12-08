import 'package:app1/ultis/hepers/heper_function.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TShimmerEffect extends StatelessWidget {
  const TShimmerEffect(
      {super.key,
      this.radius = 15,
      required this.width,
      required this.height,
      this.color});

  final double radius, width, height;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final bool dark = TheplerFunction.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: dark ? Colors.grey.shade700 : Colors.grey.shade300,
      highlightColor: dark ? Colors.grey.shade800 : Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: dark ? Colors.grey.shade400 : Colors.white,
            borderRadius: BorderRadius.circular(radius)),
      ),
    );
  }
}
