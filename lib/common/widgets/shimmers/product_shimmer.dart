import 'package:app1/common/widgets/layout/t_gird_product.dart';
import 'package:app1/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

class TGirdViewShimmers extends StatelessWidget {
  const TGirdViewShimmers(
      {super.key,
      required this.itemCount,
      required this.width,
      required this.height});
  final int itemCount;
  final double width, height;
  @override
  Widget build(BuildContext context) {
    return TGirdProduct(
      mainAxisExtent: 280,
      itemCount: itemCount,
      itemBuilder: (_, __) {
        return TShimmerEffect(
          width: width,
          height: height,
        );
      },
    );
  }
}
