import 'package:flutter/material.dart';

class TProductPrice extends StatelessWidget {
  const TProductPrice(
      {super.key,
      this.currenySign = '\$',
      required this.price,
      this.maxLine = 1,
      required this.isLarge,
      required this.lineThrough});

  final String currenySign, price;
  final int maxLine;
  final bool isLarge, lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      currenySign + price,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.titleLarge!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null,
              color: lineThrough ? Colors.red : Colors.black)
          : Theme.of(context).textTheme.titleSmall!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null,
              color: lineThrough ? Colors.red : Colors.black),
    );
  }
}
