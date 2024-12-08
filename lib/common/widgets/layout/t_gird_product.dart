import 'package:flutter/material.dart';

class TGirdProduct extends StatelessWidget {
  const TGirdProduct(
      {super.key,
      required this.itemCount,
      this.mainAxisExtent,
      required this.itemBuilder});

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: itemCount,
        // primary: true,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: mainAxisExtent,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemBuilder: itemBuilder);
  }
}
