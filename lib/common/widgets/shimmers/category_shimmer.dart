import 'package:app1/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

class TCategoryShimmers extends StatelessWidget {
  const TCategoryShimmers({super.key, required this.itemCount});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        child: ListView.separated(
            itemCount: itemCount,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(
                  height: 18,
                ),
            itemBuilder: (context, index) {
              return const Column(
                children: [
                  TShimmerEffect(
                    height: 55,
                    width: 55,
                    radius: 55,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TShimmerEffect(width: 55, height: 8)
                ],
              );
            }));
  }
}
