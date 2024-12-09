import 'package:app1/common/widgets/icons/t_circular_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TQuanityWithPrice extends StatelessWidget {
  const TQuanityWithPrice({
    super.key,
    required this.quantity,
    required this.add,
    required this.remove,
  });

  final int quantity;
  final VoidCallback add;
  final VoidCallback remove;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TCircularIcon(
          height: 32,
          onPressed: remove,
          iconColor: Colors.black,
          icon: const Icon(FontAwesomeIcons.minus),
          backgroundColor: Colors.grey,
          size: 12,
        ),
        const SizedBox(width: 10),
        Text(
          quantity.toString(),
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(width: 10),
        TCircularIcon(
          height: 32,
          onPressed: add,
          iconColor: Colors.white,
          size: 12,
          icon: const Icon(FontAwesomeIcons.plus),
          backgroundColor: Colors.blue,
        ),
      ],
    );
  }
}
